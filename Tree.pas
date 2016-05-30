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

  VAR
    Root: NodePtr;
  
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
      InitNode(Ptr)
    ELSE
      FoundPlaceToInsert(Ptr, Data)    
  END;  { InsertToTree }
  
  PROCEDURE Insert(Lexem: STRING);
  BEGIN { InsertToTree }
    InsertToTree(Root, Lexem) 
  END; { InsertToTree }
  
  PROCEDURE PrintTree(VAR FOut: TEXT; Ptr: NodePtr);
  BEGIN { PrintTree }
    IF Ptr <> NIL
    THEN
      BEGIN
        PrintTree(FOut, Ptr^.LLink);
        WRITELN(FOut, Ptr^.Lexem, ' ', Ptr^.LexemCounter);
        PrintTree(FOut, Ptr^.RLink)
      END       
  END;  { PrintTree }

  PROCEDURE PrintLexems(VAR FOut: TEXT);
  BEGIN { PrintLexems }
    PrintTree(FOut, Root)
  END; { PrintLexems }

BEGIN { TreeUnit }
  Root := NIL
END. { TreeUnit }

