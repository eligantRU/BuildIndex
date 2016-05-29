UNIT TreeUnit;
  
INTERFACE

  TYPE 
  Tree = ^NodeType;
  NodeType = RECORD
               Lexem: STRING;
               LexemCounter: LONGINT;
               LLink, RLink: Tree;
             END;
             
  PROCEDURE PrintTree(Ptr: Tree);
  PROCEDURE Insert(VAR Ptr: Tree; Data: STRING);
             
IMPLEMENTATION

  PROCEDURE Insert(VAR Ptr: Tree; Data: STRING);
  BEGIN { Insert }
    IF Ptr = NIL
    THEN
      BEGIN
        NEW(Ptr);             
        Ptr^.LexemCounter := 1;
        Ptr^.Lexem := Data;
        Ptr^.LLink := NIL;
        Ptr^.RLink := NIL;
      END
    ELSE
      IF Ptr^.RLexem > Data
      THEN
        Insert(Ptr^.LLink, Data)
      ELSE
        IF Ptr^.Lexem < Data
        THEN
          Insert(Ptr^.RLink, Data)
        ELSE
          INC(Ptr^.LexemCounter)
  END;  { Insert }
  
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

BEGIN { TreeUnit }

END. { TreeUnit }

