programa {
  inclua biblioteca Util --> u
  inclua biblioteca Texto --> txt

  // Globais
  inteiro statusPlayer[4] = {0, 0, 0, 0}
  inteiro statusInimigo[3] = {0, 0, 0}
  
  
  cadeia nomeInimigos[6] = {"", "", "", "", "", ""}
  cadeia nomePlayer[3] = {"", "", ""}

  funcao inicio() {
    //Fluxo de modo Boss Rush
    //Inicio Jogo
    escolherClasse()

    // Esqueleto
    criarInimigo(1)
    mostrarSala(1)
    combate(1)
    resetClasse()

    // Goblin
    mostrarSala(2)
    criarInimigo(2)
    combate(2)
    resetClasse()

    // Demônio
    mostrarSala(3)
    criarInimigo(3)
    combate(3)
    resetClasse()

    // Cavaleiro Negro
    mostrarSala(4)
    criarInimigo(4)
    combate(4)
    resetClasse()

    // Rei Demônio
    mostrarSala(5)
    criarInimigo(5)
    combate(5)
  }



  // Classes 

  funcao resetClasse() {
    inteiro opcao
    digitar("Gostaria de continuar com a mesma classe?\n")
    digitar("Então escolha a mesma classe novamente...")
    escreva("\n")
    escreva(" Escolha : 1 - GUERREIRO | 2 - ASSASSINO | 3 - TANK \n > ")
    leia(opcao)
    limparTela()

     enquanto (opcao < 1 ou opcao > 3) {
      digitar(" Opção inválida! \n")
      escreva(" Escolha : 1 - GUERREIRO | 2 - ASSASSINO | 3 - TANK \n > ")
      leia(opcao)
      limparTela()
    }

    criarPlayer(opcao)

    digitar("\nVOCÊ ESCOLHEU A CLASSE " + nomePlayer[opcao-1] + "!!!\n")
    limparTela()
  }



  funcao escolherClasse() {
    inteiro opcao
    digitar(" --- BEM VINDO AO RPG --- \n")
    escreva(" Escolha : 1 - GUERREIRO | 2 - ASSASSINO | 3 - TANK \n > ")
    leia(opcao)
    limparTela()

    enquanto (opcao < 1 ou opcao > 3) {
      digitar(" Opção inválida! \n")
      escreva(" Escolha : 1 - GUERREIRO | 2 - ASSASSINO | 3 - TANK \n > ")
      leia(opcao)
      limparTela()
    }

    criarPlayer(opcao)

    digitar("\nVOCÊ ESCOLHEU A CLASSE " + nomePlayer[opcao-1] + "!!!\n")
  }



  funcao criarPlayer(inteiro classe) {
    se (classe == 1) { 
      statusPlayer[0] = 100 // Vida
      statusPlayer[1] = 20  // Dano
      statusPlayer[2] = 5   // Velocidade
      statusPlayer[3] = 5   // Cura
      nomePlayer[0] = "GUERREIRO"
    }
    senao se (classe == 2) { 
      statusPlayer[0] = 50 
      statusPlayer[1] = 25 
      statusPlayer[2] = 6 
      statusPlayer[3] = 3 
      nomePlayer[1] = "ASSASSINO"
    }
    senao se (classe == 3) { 
      statusPlayer[0] = 120 
      statusPlayer[1] = 17 
      statusPlayer[2] = 2 
      statusPlayer[3] = 2 
      nomePlayer[2] = "TANK"
    }
  }



  funcao criarInimigo(inteiro tipo) {
     se (tipo == 1) { // Esqueleto
      statusInimigo[0] = 50 // Vida
      statusInimigo[1] = 15 // Dano
      statusInimigo[2] = 2 // Velocidade
      nomeInimigos[1] = "ESQUELETO"
    }
  senao se (tipo == 2) { // Goblin
      statusInimigo[0] = 60 // Vida
      statusInimigo[1] = 15 // Dano
      statusInimigo[2] = 4 // Velocidade
      nomeInimigos[2] = "GOLBIN"
    }
  senao se (tipo == 3) { // Demônio
      statusInimigo[0] = 60 // Vida
      statusInimigo[1] = 20 // Dano
      statusInimigo[2] = 4 // Velocidade
      nomeInimigos[3] = "DEMÔNIO"
    }
  senao se (tipo == 4) { // Cavaleiro Negro
      statusInimigo[0] = 100 // Vida
      statusInimigo[1] = 20 // Dano
      statusInimigo[2] = 5 // Velocidade
      nomeInimigos[4] = "(BOSS) CAVALEIRO NEGRO"
    }
  senao se (tipo == 5) { // Rei Demônio
      statusInimigo[0] = 130 // Vida
      statusInimigo[1] = 23 // Dano
      statusInimigo[2] = 5 // Velocidade
      nomeInimigos[5] = "(FINAL BOSS) REI DEMÔNIO"

} 
  }



  // Fluxo de Combate
  funcao combate(inteiro indiceInimigo) {
    inteiro numRandom
    inteiro vidaPlayerMax = statusPlayer[0]
    inteiro opcao
    
    escreva("\nUM " + nomeInimigos[indiceInimigo] + " APARECEU!!!\n")
    digitar("COMEÇA O COMBATE!\n")
    u.aguarde(1000)
    limparTela()

    enquanto (statusPlayer[0] > 0 e statusInimigo[0] > 0) {
      escreva("\n-----------------------------------------")
      escreva("\nSua Vida : ", statusPlayer[0], " | Vida do Inimigo : ", statusInimigo[0], "\n")
      digitar("O que deseja fazer?\n 1 - Atacar | 2 - Curar | 3 - Status \n > ")
      leia(opcao)
      limparTela()

    enquanto (opcao < 1 ou opcao > 3) {
      digitar(" Opção inválida! \n")
      u.aguarde(1000)
      escreva("\n-----------------------------------------")
      escreva("\nSua Vida : ", statusPlayer[0], " | Vida do Inimigo : ", statusInimigo[0], "\n")
      digitar("O que deseja fazer?\n 1 - Atacar | 2 - Curar | 3 - Status \n > ")
      leia(opcao)
      limparTela()
    }

      se (opcao == 1) {
        numRandom = u.sorteia(0, 2)
        se (numRandom == 0) { digitar("Você errou o ataque...\n") }

        senao se (numRandom == 1) { digitar("Você acertou o ataque!\n") }

        senao { digitar("ATAQUE CRÍTICO!!!\n") } 
        
        statusInimigo[0] -= (statusPlayer[1] * numRandom)
        limparTela()
        se (statusInimigo[0] > 0) {
          numRandom = u.sorteia(0, 2)
          inteiro novoDanoInimigo = statusInimigo[1] * numRandom
          
          se (numRandom == 0) { digitar("O inimigo errou o ataque!\n") limparTela() }
          senao { 
            digitar("O inimigo te causou ")
            escreva(novoDanoInimigo)
            digitar(" de dano!\n")
            statusPlayer[0] -= novoDanoInimigo
            limparTela()
          }
        } senao {
          digitar("Você derrotou ")
          escreva(nomeInimigos[indiceInimigo])
          digitar("!\n")
          limparTela()
        }
      }
      senao se (opcao == 2) {
        se (statusPlayer[3] > 0) {
          statusPlayer[0] += 30
          statusPlayer[3] -= 1
          digitar("Você se curou! Restam " + statusPlayer[3] + " curas.\n")
          limparTela()
          
          se (statusPlayer[0] > vidaPlayerMax) {
            statusPlayer[0] = vidaPlayerMax
          }
        } senao {
          digitar("Sem poções de cura!\n")
          limparTela()
        }
        
        inteiro danoExtra = statusInimigo[1] * u.sorteia(0, 1)
        statusPlayer[0] -= danoExtra
        digitar(nomeInimigos[indiceInimigo] + " te golpeou enquanto você se curava: -" + danoExtra + "\n")
        limparTela()
      }
      senao se (opcao == 3) {
        mostrarStatus()
        limparTela()
      }
      senao { pare }
    }
    digitar("\n --- FIM DO COMBATE --- \n")
    limparTela()
  }

  funcao mostrarStatus() {
    limpa()
    escreva("Vida: " +statusPlayer[0] + " PV\n")
    escreva("Ataque: " +statusPlayer[1] + " ATQ\n")
    escreva("Velocidade: " +statusPlayer[2] + " VEL\n")
    escreva("Quantidade de Curas: " +statusPlayer[3] + " C\n")
    u.aguarde(1500)
  }

  // Funções utilitárias

  funcao limparTela() {
    cadeia texto = "\n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n "
    inteiro tamanho = txt.numero_caracteres(texto)
    para (inteiro i = 0; i < tamanho; i++) {
      escreva(txt.obter_caracter(texto, i))
      u.aguarde(17)
    }
  }

  funcao digitar (cadeia texto) {
    inteiro tamanho = txt.numero_caracteres(texto)
    para (inteiro i = 0; i < tamanho; i++) {
      escreva(txt.obter_caracter(texto, i))
      u.aguarde(20)
    }
  }

    funcao digitarLento(cadeia texto) {
    inteiro tamanho = txt.numero_caracteres(texto)
    para (inteiro i = 0; i < tamanho; i++) {
      escreva(txt.obter_caracter(texto, i))
      u.aguarde(10)
    }
  }

  funcao mostrarSala(inteiro sala) {
    escolha(sala) {
      caso 1:
      limpa()
      para(inteiro i = 0; i < 3; i++) {
        escreva("* * * * * * * * * * *\n")
        escreva("* * * * * * * * * * *\n")
        escreva("*   * 2 * 3 * 4 * 5 *\n")
        u.aguarde(450)
        limpa()
        escreva("* * * * * * * * * * *\n")
        escreva("* * * * * * * * * * *\n")
        escreva("* 1 * 2 * 3 * 4 * 5 *\n")
        u.aguarde(450)
        limpa()
      }
      limpa()
      digitarLento("Sala 1          \n")
      u.aguarde(450)
      digitarLento("Entrando na caverna... \n")
      
      pare
      caso 2:
      limpa()
        para(inteiro i = 0; i < 3; i++) {
        escreva("* * * * * * * * * * *\n")  
        escreva("* * * * * * * * * * *\n")  
        escreva("* 1 *   * 3 * 4 * 5 *\n")
        u.aguarde(450)
        limpa()
        escreva("* * * * * * * * * * *\n")  
        escreva("* * * * * * * * * * *\n")
        escreva("* 1 * 2 * 3 * 4 * 5 *\n")
        u.aguarde(450)
        limpa()
      }
      limpa()
      digitarLento("Sala 2          \n")
      u.aguarde(450)
      digitarLento("Goblins a espreita...     \n")
      
      pare
      caso 3:
      limpa()
        para(inteiro i = 0; i < 3; i++) {
        escreva("* * * * * * * * * * *\n")
        escreva("* * * * * * * * * * *\n")
        escreva("* 1 * 2 *   * 4 * 5 *\n")
        u.aguarde(450)
        limpa()
        escreva("* * * * * * * * * * *\n")
        escreva("* * * * * * * * * * *\n")
        escreva("* 1 * 2 * 3 * 4 * 5 *\n")
        u.aguarde(450)
        limpa()
      }
      limpa()
      digitarLento("Sala 3          \n")
      u.aguarde(450)
      digitarLento("Uma água benta cairia bem...     \n")
      
      pare
      caso 4:
      limpa()
        para(inteiro i = 0; i < 3; i++) {
          escreva("* * * * * * * * * * *\n")
          escreva("* * * * * * * * * * *\n")
        escreva("* 1 * 2 * 3 *   * 5 *\n")
        u.aguarde(450)
        limpa()
        escreva("* * * * * * * * * * *\n")
        escreva("* * * * * * * * * * *\n")
        escreva("* 1 * 2 * 3 * 4 * 5 *\n")
        u.aguarde(450)
        limpa()
      }
      limpa()
      digitarLento("Sala 4          \n")
      u.aguarde(450)
      digitarLento("Lar do melhor espadachim do submundo...     \n")
      u.aguarde(450)
      
      pare
      caso 5:
      limpa()
       para(inteiro i = 0; i < 3; i++) {
        escreva("* * * * * * * * * * *\n")
        escreva("* * * * * * * * * * *\n")
        escreva("* 1 * 2 * 3 * 4 *   *\n")
        u.aguarde(450)
        limpa()
        escreva("* * * * * * * * * * *\n")
        escreva("* * * * * * * * * * *\n")
        escreva("* 1 * 2 * 3 * 4 * 5 *\n")
        u.aguarde(450)
        limpa()
      }
      limpa()
      digitarLento("Sala 5 FINAL          \n")
      u.aguarde(600)
      digitarLento("É HORA DO EXPURGO FINAL!!!          \n")
      u.aguarde(600)
      
      pare
      
    }
    
  }
}