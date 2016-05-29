PROGRAM BuildIndex(INPUT, OUTPUT);  
USES 
  LexemUnit, TreeUnit;           
VAR
  Root: Tree;

PROCEDURE IndexFile(VAR Fin: TEXT; VAR Root: Tree);
VAR
  Lexem: STRING;
BEGIN { IndexFile }
  Root := NIL;
  WHILE NOT EOF(Fin)
  DO
    BEGIN
      LexemUnit.SkipGarbage(Fin);
      Lexem := LexemUnit.GetLexem(Fin);
      IF (LENGTH(Lexem) > 0)
      THEN
        TreeUnit.Insert(Root, Lexem)
    END
END; { IndexFile }

BEGIN { BuildIndex }
  IndexFile(INPUT, Root);
  TreeUnit.PrintTree(Root)
END. { BuildIndex }

