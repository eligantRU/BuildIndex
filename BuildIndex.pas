PROGRAM BuildIndex(INPUT, OUTPUT);  
USES                             
  LexerUnit, TreeUnit;   
  
PROCEDURE IndexFile(VAR Fin: TEXT);
VAR
  Lexem: STRING;
BEGIN { IndexFile }
  WHILE NOT EOF(Fin)
  DO
    BEGIN             
      Lexem := LexerUnit.GetLexem(Fin);
      IF (LENGTH(Lexem) > 0)
      THEN
        TreeUnit.Insert(Lexem)
    END
END; { IndexFile }

BEGIN { BuildIndex }
  IndexFile(INPUT);
  TreeUnit.PrintLexems(OUTPUT); 
END. { BuildIndex }

