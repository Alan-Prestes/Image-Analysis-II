<p align="center"> <img src="https://user-images.githubusercontent.com/87569077/236585012-9f31c629-35f3-40c3-99de-541efcb9db63.jpg" width="200">
<h1 align="center"> Dashboard para análise de imagem: Determinação de percentual </h5>

## Descrição do Projeto
Dashboard criado para a segmentação de imagens com o objetivo de o percentual de pixels ocupado por um objeto alvo.

## O que a aplicação é capaz de fazer :checkered_flag:
1. Importar arquivos em PNG ou JPEG;
2. Formatar arquivo importado;
3. Escolher o melhor índice de segmentação do background e foreground;
4. Definir o melhor threshold de segmentação do background e foreground;

### Como executar:
Para executar abra o _`R Studio`_ e execute o seguinte comando:
```ruby
#Caso não tenha os pacotes abaixo instalados, faça a instalação
install.packages(c("ExpImage", "shiny", "shinythemes", "writexl","raster", "sp"))
library(shiny)
runGitHub(repo="image-analysis-II", username = "Alan-Prestes", ref="main")
```

## Como proceder :punch:
**1.** Importe a imagem desejada (em formato PNG ou JPEG); <br />
**2.** Após escolher o arquivo, clique em **_Importar_**; <br />
![Passo1](https://github.com/Alan-Prestes/Image-Analysis-II/assets/87569077/c34f5739-9703-4be8-9181-cba297f02406)

**3.** Caso deseje editar a imagem importada, clique em **_“Formatar imagem”_**. <br />
![Passo2](https://github.com/Alan-Prestes/Image-Analysis-II/assets/87569077/f02435d1-da2e-4f40-87b2-2e1bfc10240b)

**3.1** Caso deseje redimensionar a imagem, basta escolher a percentagem desejada (sugere-se esta edição para imagens de alta resolução); <br />
**3.2** É possível também cortar a imagem caso deseje remover algo que prejudique a análise; <br />
**3.3** Importante estar atento à largura e altura da imagem uma vez que seja necessário escolher um intervalo mínimo e máximo de acordo com o tamanho da mesma. <br />
**4.** Após formatada a imagem, clique em **_“Definir imagem”_**. <br />
**OBS: Caso não seja necessária a edição, desconsidere a etapa 3.1, 3.2 e 3.3.** <br />
![Passo3](https://github.com/Alan-Prestes/Image-Analysis-II/assets/87569077/d2b62fa8-37a3-42f5-b4ca-f9f57a590c45)

**5.** Escolha o melhor índice de segmentação (há disponível 25 índices diferentes);<br />
![Passo4](https://github.com/Alan-Prestes/Image-Analysis-II/assets/87569077/2da4beb0-0853-4390-9daa-6de24f640c4c)

**6.** Clique em **_“Segmentação do fundo”_** para a segmentação da área total da imagem;<br />
![Passo5](https://github.com/Alan-Prestes/Image-Analysis-II/assets/87569077/e537f4a3-aab1-43a5-b151-b9265d0c31d8)

**6.** O Objetivo nesta seção é deixar o **_objeto-alvo (foreground)_** da cor branca (presença de pixel) e o **_fundo (background)_** da cor preta (ausência de pixel); <br />
**6.1** Escolha o melhor índice (definido na etapa 5); <br />
**6.2** Definição do limiar (threshold). OBS: utilize a imagem à esquerda para definir o melhor valor; <br />
**6.3** Caso deseja selecionar pixels maior que o limiar, marque a caixa; <br />
**6.4** Caso deseje desconsiderar valores nulos no background (fundo), assinale a caixa;<br />
**6.5** Caso haja ruídos (pixels escuros) no interior do foreground (objeto-alvo), assinale esta caixa. <br />
![Passo6](https://github.com/Alan-Prestes/Image-Analysis-II/assets/87569077/9e7f4ac9-57f5-4334-bfde-b994d089e824)

**7.** Clique em **_“Segmentação da área”_** para a segmentação da área-alvo (área a ser medida);
OBS: O Objetivo nesta seção é deixar o **_objeto-alvo (foreground)_** da cor branca (presença de pixel) e o **_fundo (background)_** da cor preta (ausência de pixel);<br />
![Passo7](https://github.com/Alan-Prestes/Image-Analysis-II/assets/87569077/16ea6b5a-968f-411d-b0b2-d98e176dc2a7)

**7.1** Escolha o melhor índice (definido na etapa 5); <br />
**7.2** Definição do limiar **_(Threshold)_**. OBS: utilize a imagem à esquerda para definir o melhor valor; <br />
**7.3** Caso deseja selecionar pixels maior que o limiar, marque a caixa;<br />
**7.4** Caso deseje desconsiderar valores nulos no background (fundo), assinale a caixa<br />
**7.5** Caso haja ruídos (pixels escuros) no interior do foreground (objeto-alvo), assinale esta caixa. <br />
**8.** Definidos todos os parâmetros para a segmentação, clique em **_“Definir percentagem”_**; <br />
![Passo8](https://github.com/Alan-Prestes/Image-Analysis-II/assets/87569077/f40bd59e-16c0-4c43-9141-651d365015b6)

**9.** Direcione-se a aba **_“Percentagem”_**.<br />
**9.1** Imagem original no início do processo;<br />
**9.2** Imagem com a área segmentada (a ser medida) colorida;<br />
**9.3** Imagem com a área segmentada (a ser medida) circulada;<br />
**9.4** Determinação da percentagem a área segmentada;<br />
![Passo9](https://github.com/Alan-Prestes/Image-Analysis-II/assets/87569077/11a7cacc-f1a9-48d0-9ada-2aa992871241)

### Pacotes utilizados
* ExpImage: [CRAN](https://cran.r-project.org/web/packages/ExpImage/ExpImage.pdf)
* shiny: [CRAN](https://cran.r-project.org/package=shiny)
* shinythemes: [CRAN](https://cran.r-project.org/package=shinythemes)
* writexl: [CRAN](https://cran.r-project.org/package=writexl)
* raster: [CRAN](https://cran.r-project.org/package=raster)
* sp: [CRAN](https://cran.r-project.org/package=sp)
