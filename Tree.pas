UNIT TreeUnit;
  
INTERFACE

  TYPE 
    Tree = ^NodeType; // NodePtr
    NodeType = RECORD
                 Lexem: STRING;
                 LexemCounter: LONGINT;
                 LLink, RLink: Tree
               END;
             
  PROCEDURE PrintLexems();
  PROCEDURE InsertToTree(Data: STRING);
             
IMPLEMENTATION

  VAR
    Root: Tree;
  
  PROCEDURE Insert(VAR Ptr: Tree; Data: STRING);
  
  PROCEDURE FoundInsertPlace(VAR Ptr: Tree; Data: STRING);
  BEGIN { FoundInsertPlace }
    IF Ptr^.Lexem > Data
    THEN
      Insert(Ptr^.LLink, Data)
    ELSE
      IF Ptr^.Lexem < Data
      THEN
        Insert(Ptr^.RLink, Data)
      ELSE                   
        INC(Ptr^.LexemCounter)
  END; { FoundInsertPlace }
  
  BEGIN { Insert }
    IF Ptr = NIL
    THEN
      BEGIN
        NEW(Ptr);             
        Ptr^.LexemCounter := 1;
        Ptr^.Lexem := Data;
        Ptr^.LLink := NIL;
        Ptr^.RLink := NIL   
      END
    ELSE
      FoundInsertPlace(Ptr, Data)    
  END;  { Insert }
  
  PROCEDURE InsertToTree(Data: STRING);
  BEGIN { InsertToTree }
    Insert(Root, Data) 
  END; { InsertToTree }
  
  PROCEDURE PrintTree(Ptr: Tree);
  BEGIN { PrintTree }
    IF Ptr <> NIL
    THEN
      BEGIN
        PrintTree(Ptr^.LLink);
        WRITELN(Ptr^.Lexem, ' ', Ptr^.LexemCounter);
        PrintTree(Ptr^.RLink)
      END       
  END;  { PrintTree }

  PROCEDURE PrintLexems();
  BEGIN { PrintLexems }
    PrintTree(Root)
  END; { PrintLexems }

BEGIN { TreeUnit }
  Root := NIL
END. { TreeUnit }

