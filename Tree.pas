UNIT TreeUnit;
  
INTERFACE

  TYPE 
    NodePtr = ^NodeType;
    NodeType = RECORD
                 Lexem: STRING;
                 LexemCounter: LONGINT;
                 LLink, RLink: NodePtr
               END;
             
  PROCEDURE PrintLexems(VAR FOut: TEXT);
  PROCEDURE Insert(Lexem: STRING);
             
IMPLEMENTATION
  USES 
    LexerUnit;
  CONST
    MaxTreeSize = 4096;
  VAR
    Root: NodePtr;
    TreeSize: LONGINT;
    TempF1, TempF2, TempF3: TEXT;
    
  PROCEDURE CopyFile(VAR FIn, FOut: TEXT);
  VAR
    Ch: CHAR;
  BEGIN { CopyFile }
    RESET(FIn);
    REWRITE(FOut);
    WHILE NOT EOF(FIn)
    DO
      BEGIN
        WHILE NOT EOLN(FIn)
        DO
          BEGIN 
            READ(FIn, Ch);
            WRITE(FOut, Ch)
          END;
        READLN(FIn);
        WRITELN(FOut)    
      END;
    RESET(FIn); 
    REWRITE(FIn) 
  END; { CopyFile }    
    
  PROCEDURE PrintTree(VAR FOut: TEXT; Ptr: NodePtr);
  BEGIN { PrintTree }
    IF Ptr <> NIL
    THEN
      BEGIN
        PrintTree(FOut, Ptr^.LLink);  
        WRITELN(FOut, Ptr^.Lexem, ' ', Ptr^.LexemCounter);
        PrintTree(FOut, Ptr^.RLink)
      END;          
  END;  { PrintTree }
  
  PROCEDURE FreeTree(VAR Ptr: NodePtr);
  
    PROCEDURE Free(VAR Ptr: NodePtr);
    BEGIN { Free }
      IF Ptr <> NIL
        THEN
        BEGIN
          Free(Ptr^.LLink);
          IF Ptr^.LLink <> NIL
          THEN
            BEGIN
              DISPOSE(Ptr^.LLink);
              Ptr^.LLink := NIL
            END;    
        
          Free(Ptr^.RLink);
          IF Ptr^.RLink <> NIL
          THEN
            BEGIN
              DISPOSE(Ptr^.RLink);
              Ptr^.RLink := NIL
            END;    
        END;      
    END; { Free }
  
  BEGIN { FreeTree }
    Free(Ptr);
    DISPOSE(Root);
    Root := NIL;
  END; { FreeTree }

  PROCEDURE MergeTreeToFile(VAR Ptr: NodePtr);
  
    PROCEDURE Merge(VAR F1, F2, F3: TEXT); 
    VAR
      Lexem2, Lexem3: STRING;
      Counter2, Counter3: LONGINT;
      Have2, Have3: BOOLEAN;
    
      PROCEDURE TryReadCouple(VAR Have: BOOLEAN; VAR F: TEXT; VAR Lexem: STRING; VAR Counter: LONGINT);
      BEGIN { TryReadCouple }
        IF (NOT Have) AND (NOT EOLN(F)) AND (NOT EOF(F))
          THEN
            BEGIN           
              Lexem := LexerUnit.GetLexem(F);
              READLN(F, Counter);        
              Have := TRUE
            END
      END; { TryReadCouple } 
      
      PROCEDURE Sorting(VAR FOut: TEXT; Lexem2, Lexem3: STRING; Counter2, Counter3: LONGINT; VAR Have2, Have3: BOOLEAN);
      BEGIN { Sorting }
        IF Lexem2 = Lexem3
        THEN
          BEGIN               
            WRITELN(FOut, Lexem2, ' ', Counter2 + Counter3);
            Have2 := FALSE;
            Have3 := FALSE
          END
        ELSE  
          IF Lexem2 < Lexem3
          THEN
            BEGIN               
              WRITELN(FOut, Lexem2, ' ', Counter2);
              Have2 := FALSE
            END
          ELSE
            BEGIN             
              WRITELN(FOut, Lexem3, ' ', Counter3);
              Have3 := FALSE
            END
      END; { Sorting }
      
      PROCEDURE MergeRemains(VAR Fout: TEXT; Lexem2, Lexem3: STRING; Counter2, Counter3: LONGINT; VAR Have2, Have3: BOOLEAN);
      BEGIN { MergeRemains }  
        IF Have2
        THEN
          BEGIN      
            WRITELN(FOut, Lexem2, ' ', Counter2);
            Have2 := FALSE
          END;
        IF Have3
        THEN
          BEGIN           
            WRITELN(FOut, Lexem3, ' ', Counter3);
            Have3 := FALSE
          END
      END; { MergeRemains }  
      
    BEGIN { Merge }
      REWRITE(F1);
      RESET(F2);
      RESET(F3);
      Have2 := FALSE;
      Have3 := FALSE; 
      WHILE (NOT EOLN(F2)) OR (NOT EOLN(F3)) OR (Have2 = TRUE) OR (Have3 = TRUE)
      DO
        BEGIN   
          TryReadCouple(Have2, F2, Lexem2, Counter2);  
          TryReadCouple(Have3, F3, Lexem3, Counter3);  
          IF Have2 AND Have3
          THEN
            Sorting(F1, Lexem2, Lexem3, Counter2, Counter3, Have2, Have3)
          ELSE
            MergeRemains(F1, Lexem2, Lexem3, Counter2, Counter3, Have2, Have3)       
        END;
      REWRITE(F2);
      REWRITE(F3) 
    END; { Merge }
  
  BEGIN { MergeTreeToFile }    
    PrintTree(TempF1, Root);
    FreeTree(Root);
    Merge(TempF2, TempF3, TempF1);
    CopyFile(TempF2, TempF3)
  END; { MergeTreeToFile } 
  
  PROCEDURE InsertToTree(VAR Ptr: NodePtr; Data: STRING);
    
    PROCEDURE FoundPlaceToInsert(VAR Ptr: NodePtr; Data: STRING);
    BEGIN { FoundInsertPlace }
      IF Ptr^.Lexem > Data
      THEN              
        InsertToTree(Ptr^.LLink, Data)
      ELSE
        IF Ptr^.Lexem < Data
        THEN
          InsertToTree(Ptr^.RLink, Data)
        ELSE                   
          INC(Ptr^.LexemCounter)
    END; { FoundInsertPlace }
  
    PROCEDURE InitNode(VAR Ptr: NodePtr);
    BEGIN { InitNode }
      NEW(Ptr);             
      Ptr^.LexemCounter := 1;
      Ptr^.Lexem := Data;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL     
    END; { InitNode }
  
  BEGIN { InsertToTree }
    IF Ptr = NIL
    THEN
      BEGIN
        InitNode(Ptr);
        INC(TreeSize)
      END      
    ELSE
      FoundPlaceToInsert(Ptr, Data);
      
    IF TreeSize = MaxTreeSize
    THEN
      BEGIN
        MergeTreeToFile(Root);
        TreeSize := 0;
      END    
  END;  { InsertToTree }
  
  PROCEDURE Insert(Lexem: STRING);
  BEGIN { InsertToTree }
    InsertToTree(Root, Lexem) 
  END; { InsertToTree }

  PROCEDURE PrintLexems(VAR FOut: TEXT);
  BEGIN { PrintLexems }
    MergeTreeToFile(Root);
    CopyFile(TempF3, OUTPUT)
  END; { PrintLexems }

BEGIN { TreeUnit }
  Root := NIL;
  TreeSize := 0;
  REWRITE(TempF1);
  REWRITE(TempF2);
  REWRITE(TempF3)
END. { TreeUnit }

