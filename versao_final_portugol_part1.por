programa {
  inclua biblioteca Util --> u
  inclua biblioteca Texto --> txt

  // Globais
  inteiro statusPlayer[4] = {0, 0, 0, 0}
  inteiro statusInimigo[3] = {0, 0, 0}
  
  
  cadeia nomeInimigos[6] = {"", "", "", "", "", ""}
  cadeia nomePlayer[3] = {"", "", ""}

  funcao inicio() {
    escolherClasse()
    
    inteiro tipoInimigo = 1 
    criarInimigo(tipoInimigo)
    
   
    combate(tipoInimigo - 1) 
  }

  funcao escolherClasse() {
    inteiro opcao
    digitar(" --- BEM VINDO AO RPG --- \n")
    escreva(" Escolha : 1 - GUERREIRO | 2 - ASSASSINO | 3 - TANK \n > ")
    leia(opcao)

    enquanto (opcao < 1 ou opcao > 3) {
      digitar(" Opção inválida! \n")
      escreva(" Escolha : 1 - GUERREIRO | 2 - ASSASSINO | 3 - TANK \n > ")
      leia(opcao)
    }

    criarPlayer(opcao)
    // Ajuste aqui: opcao - 1 para pegar o nome certo no array
    digitar("\nVOCÊ ESCOLHEU A CLASSE " + nomePlayer[opcao-1] + "!!!\n")
  }

  funcao criarPlayer(inteiro classe) {
    se (classe == 1) { 
      statusPlayer[0] = 100 // Vida
      statusPlayer[1] = 15  // Dano
      statusPlayer[2] = 5   // Velocidade
      statusPlayer[3] = 2   // Cura
      nomePlayer[0] = "GUERREIRO"
    }
    senao se (classe == 2) { 
      statusPlayer[0] = 50 
      statusPlayer[1] = 25 
      statusPlayer[2] = 6 
      statusPlayer[3] = 4 
      nomePlayer[1] = "ASSASSINO"
    }
    senao se (classe == 3) { 
      statusPlayer[0] = 120 
      statusPlayer[1] = 12 
      statusPlayer[2] = 2 
      statusPlayer[3] = 2 
      nomePlayer[2] = "TANK"
    }
  }

  funcao criarInimigo(inteiro tipo) {
    se (tipo == 1) { 
      statusInimigo[0] = 50 
      statusInimigo[1] = 10 // Dano reduzido para teste
      statusInimigo[2] = 2   
      nomeInimigos[0] = "ESQUELETO"
    }
    senao se (tipo == 2) { 
      statusInimigo[0] = 60 
      statusInimigo[1] = 15 
      statusInimigo[2] = 4 
      nomeInimigos[1] = "GOBLIN"
    }
    // ... (restante dos inimigos seguindo o mesmo padrão)
  }

  funcao combate(inteiro indiceInimigo) {
    inteiro numRandom
    inteiro vidaPlayerMax = statusPlayer[0]
    inteiro opcao
    
    escreva("\nUM " + nomeInimigos[indiceInimigo] + " APARECEU!!!\n")
    digitar("COMEÇA O COMBATE!\n")
    u.aguarde(1000)

    enquanto (statusPlayer[0] > 0 e statusInimigo[0] > 0) {
      escreva("\n-----------------------------------------")
      escreva("\nSua Vida : ", statusPlayer[0], " | Vida do Inimigo : ", statusInimigo[0], "\n")
      digitar("O que deseja fazer?\n 1 - Atacar | 2 - Curar | 3 - Sair \n > ")
      leia(opcao)

      se (opcao == 1) {
        numRandom = u.sorteia(0, 2)
        se (numRandom == 0) { digitar("Você errou o ataque...\n") }

        senao se (numRandom == 1) { digitar("Você acertou o ataque!\n") }

        senao { digitar("ATAQUE CRÍTICO!!!\n") } 
        
        statusInimigo[0] -= (statusPlayer[1] * numRandom)

        se (statusInimigo[0] > 0) {
          numRandom = u.sorteia(0, 2)
          inteiro novoDanoInimigo = statusInimigo[1] * numRandom
          
          se (numRandom == 0) { digitar("O inimigo errou o ataque!\n") }
          senao { 
            escreva("O inimigo te causou ", novoDanoInimigo, " de dano!\n")
            statusPlayer[0] -= novoDanoInimigo
          }
        } senao {
          escreva("Você derrotou o ", nomeInimigos[indiceInimigo], "!\n")
        }
      }
      senao se (opcao == 2) {
        se (statusPlayer[3] > 0) {
          statusPlayer[0] += 30
          statusPlayer[3] -= 1
          digitar("Você se curou! Restam " + statusPlayer[3] + " curas.\n")
          
          se (statusPlayer[0] > vidaPlayerMax) {
            statusPlayer[0] = vidaPlayerMax
          }
        } senao {
          digitar("Sem poções de cura!\n")
        }
        
        inteiro danoExtra = statusInimigo[1] * u.sorteia(0, 1)
        statusPlayer[0] -= danoExtra
        escreva("O inimigo te golpeou enquanto você se curava: -", danoExtra, "\n")
      }
      senao { pare }
    }
    digitar("\n --- FIM DO COMBATE --- \n")
  }

  funcao digitar (cadeia texto) {
    inteiro tamanho = txt.numero_caracteres(texto)
    para (inteiro i = 0; i < tamanho; i++) {
      escreva(txt.obter_caracter(texto, i))
      u.aguarde(20)
    }
  }
}