%{
  #include <cstdio>
  #include <iostream>
  #include <map>
  using namespace std;

  map<string,float> variaveis;

  // declarar as coisas do flex que o Bison precisa saber
  extern int yylex();
  extern int yyparse();
  extern FILE *yyin;
 
  void yyerror(const char *s);
%}

%union {
  int ival;
  float fval;
  char *sval;
}
%token <ival> INT
%token <fval> FLOAT
%token <sval> VAR
%token <sval>RECEBE

%%

cod: cod comandos
  | comandos
  ;

comandos:
  INT { cout << "Int: " << $1 << endl;}
  | FLOAT { cout << "Float: " << $1 << endl;}
  | VAR { cout << "Variavel: " << $1 << endl;}
  //| RECEBE { cout << "bison found a REC: " << $1 << endl;}
  | VAR RECEBE FLOAT { 
      //verificar se existe,se existir eu atualizo.
      if(variaveis.find($1) != variaveis.end()){
          variaveis.find($1)->second = $3;
          cout << "Valor: " << variaveis.find($1)->second << endl;
      }else{
          variaveis.insert({$1,$3});
          cout << "Valor: " << variaveis.find($1)->second << endl;
      }
      cout << "Bison variavel recebe: " << $1 << $2<< $3 << endl;
    }
  ; 

%%

int main(int, char**) {
  FILE *myfile = fopen("a.code.file", "r"); //abrir o arquivo
  yyin = myfile;// ler o arquivo
  yyparse();// analisar a entrada
}

void yyerror(const char *s) {
  cout << "EEK, parse error!  Message: " << s << endl;
  exit(-1);//parar
}
