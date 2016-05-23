PROGRAM BuildIndex(INPUT, OUTPUT); 
CONST
  AllowedCharSet = ['a'..'z', 'A'..'Z', 'à'..'ÿ', 'À'..'ß', '¸', '¨', '''', '-']; 
TYPE 
  Tree = ^NodeType;
  NodeType = RECORD
               RWord: STRING;
               WordCounter: LONGINT;
               LLink, RLink: Tree;
             END;
VAR
  Root: Tree;

PROCEDURE Insert(VAR Ptr: Tree; Data: STRING);
BEGIN { Insert }
  IF Ptr = NIL
  THEN
    BEGIN
      NEW(Ptr);             
      Ptr^.WordCounter := 1;
      Ptr^.RWord := Data;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL;
    END
  ELSE
    IF Ptr^.RWord > Data
    THEN
      Insert(Ptr^.LLink, Data)
    ELSE
      IF Ptr^.RWord < Data
      THEN
        Insert(Ptr^.RLink, Data)
      ELSE
        INC(Ptr^.WordCounter)
END;  { Insert }

PROCEDURE PrintTree(Ptr: Tree);
BEGIN { PrintTree }
  IF Ptr <> NIL
  THEN
    BEGIN
      PrintTree(Ptr^.LLink);
      WRITELN(Ptr^.RWord, ' ', Ptr^.WordCounter);
      PrintTree(Ptr^.RLink)
    END
END;  { PrintTree }

PROCEDURE SkipGarbage(VAR Fin: TEXT);
VAR
  Ch: CHAR;
BEGIN { SkipGarbage }
  IF EOLN(Fin)
  THEN
    READLN(Fin);
  WHILE NOT EOLN(Fin) AND NOT EOF(Fin)
  DO
    BEGIN
      IF NOT(Fin^ IN AllowedCharSet)
      THEN
        READ(Fin, Ch)
      ELSE
        BREAK
    END  
END; { SkipGarbage }

FUNCTION GetWord(VAR Fin: TEXT): STRING;  
VAR
  Ch: CHAR;
  ReadingWord: STRING;
BEGIN { GetWord }
  ReadingWord := '';
  WHILE NOT EOLN(Fin) AND NOT EOF(Fin)
  DO
    BEGIN
      READ(Fin, Ch);        
      IF NOT(Ch IN AllowedCharSet)      
      THEN
        BREAK;
      ReadingWord := ReadingWord + UpCase(Ch)
    END;
  GetWord := ReadingWord  
END; { GetWord }

PROCEDURE IndexFile(VAR Fin: TEXT; VAR Root: Tree);
VAR
  RWord: STRING;
BEGIN { IndexFile }
  Root := NIL;
  WHILE NOT EOF(Fin)
  DO
    BEGIN
      SkipGarbage(Fin);
      RWord := GetWord(Fin);
      IF (length(RWord) > 0)
      THEN
        Insert(Root, RWord)
    END
END; { IndexFile }

BEGIN { BuildIndex }
  IndexFile(INPUT, Root);
  PrintTree(Root)
END. { BuildIndex }
