UNIT LexemUnit;

INTERFACE

  CONST
    OrthographyCharSet = ['''', '-'];
    AlphabetCharSet = ['a'..'z', 'A'..'Z', 'à'..'ÿ', 'À'..'ß', '¸', '¨'];
    AllowedCharSet = AlphabetCharSet + OrthographyCharSet; 
    
  FUNCTION CorrectLexem(VAR Lexem: STRING): STRING;
  FUNCTION GetLexem(VAR Fin: TEXT): STRING;
  PROCEDURE SkipGarbage(VAR Fin: TEXT);  
  
IMPLEMENTATION

  FUNCTION CorrectLexem(VAR Lexem: STRING): STRING;
  VAR
  StartLexemPosition, EndLexemPosition: INTEGER;

  FUNCTION GetStartLexemPosition(Lexem: STRING): INTEGER;
  VAR
    i: INTEGER;
  BEGIN { GetStartLexemPosition }   
    GetStartLexemPosition := 0;   
    IF LENGTH(Lexem) > 0
    THEN   
      BEGIN
        FOR i := 1 TO LENGTH(Lexem)
        DO
          IF (Lexem[i] IN AlphabetCharSet)
          THEN
            BREAK;
        GetStartLexemPosition := i 
      END      
  END; { GetStartLexemPosition }   

  FUNCTION GetEndLexemPosition(Lexem: STRING): INTEGER;
  VAR
    i: INTEGER;
  BEGIN { GetEndLexemPosition }  
    GetEndLexemPosition := 0;
    IF LENGTH(Lexem) > 0
    THEN   
      BEGIN
        FOR i := LENGTH(Lexem) DOWNTO 1
        DO
          IF (Lexem[i] IN AlphabetCharSet)
          THEN
            BREAK;
        GetEndLexemPosition := i
      END      
  END; { GetEndLexemPosition } 

  FUNCTION Trim(Lexem: STRING; StartPosition, EndPosition: INTEGER): STRING;
  VAR
    i: INTEGER;
    NewLexem: STRING;
  BEGIN { Trim }
    Trim := '';
    NewLexem := '';
  
    IF (LENGTH(Lexem) > 0) AND NOT((LENGTH(Lexem) = 1) AND (Lexem[1] IN OrthographyCharSet))
    THEN
      BEGIN
        FOR i := StartPosition TO EndPosition
        DO   
          NewLexem := NewLexem + Lexem[i];
        Trim := NewLexem
      END      
  END; { Trim }
  
  BEGIN { CorrectLexem }
    StartLexemPosition := GetStartLexemPosition(Lexem);
    EndLexemPosition := GetEndLexemPosition(Lexem);
    CorrectLexem := Trim(Lexem, StartLexemPosition, EndLexemPosition)
  END; { CorrectLexem }
  
  FUNCTION GetLexem(VAR Fin: TEXT): STRING;  
  VAR
    Ch: CHAR;
    Lexem: STRING;
  BEGIN { GetLexem }
    Lexem := '';
    WHILE NOT EOLN(Fin) AND NOT EOF(Fin)
    DO
      BEGIN
        READ(Fin, Ch);        
        IF NOT(Ch IN AllowedCharSet)      
        THEN
          BREAK;  
        Lexem := Lexem + UpCase(Ch)
      END;
    GetLexem := CorrectLexem(Lexem)  
  END; { GetLexem }
  
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
  
BEGIN { LexemUnit }

END. { LexemUnit }
