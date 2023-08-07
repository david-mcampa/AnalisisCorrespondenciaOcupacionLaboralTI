# Análisis de Correspondencia para Datos de Ocupación Laboral en la Industria TI

Utilizando el análisis de correspondencia, se investigan los requisitos educativos, las herramientas principales, y los salarios asociados a los roles relacionados 
al manejo de datos dentro de la Industria TI.

## Análisis Exploratorio
La base de datos _kaggle\_survey\_2020\_responses.csv_, contiene las respuestas de los participantes de la encuesta de Kaggle, que incluyen información sobre su experiencia, habilidades, educación, empleo y otras áreas relacionadas con la ciencia de datos. Dicha base cuenta con más de 39 preguntas (columnas) y  y 20,036 respuestas (filas) por usuarios de diferentes partes del mundo. Algunas de las variables con la que cuenta la base son: 


* What is your age (\# years)?
* What is your gender? - Selected Choice
* In which country do you currently reside?
* What is the highest level of formal education that you have attained or plan to attain within the next 2 years?
* Select the title most similar to your current role (or most recent title if retired): - Selected Choice
* What programming language would you recommend an aspiring data scientist to learn first? - Selected Choice
* For how many years have you used machine learning methods? \\

Este gráfico nos proporciona información sobre los puestos más populares que la gente cree ocupar en su trabajo, podemos observar que el cargo más popular es el de científico de datos, le siguen ingeniero de software y analista de datos (esto sin contar a 'otros' y 'desempleados').

![trabajos](https://github.com/david-mcampa/AnalisisCorrespondenciaOcupacionLaboralTI/assets/74944322/3a7347ec-120c-4356-8bb5-f2ddfa2cc22f)

En la siguiente figura tenemos un gráfico de conteo de los puestos de trabajo por continente y separados por géneros masculino y femenino. En el gráfico podemos observar que la mayoría de los encuestados en el continente asiático  son estudiantes. Del mismo modo, en casi todos los continentes, el puesto de trabajo más popular es el de científico de datos (de acuerdo a la proporción de encuestados de cada país). Otra observación importante es que, las mujeres tienen menos presencia para los mismos puestos que los hombres. 

![trabajoscont](https://github.com/david-mcampa/AnalisisCorrespondenciaOcupacionLaboralTI/assets/74944322/589e9eaa-399c-44fa-a088-9b7320d5d5d7)


Finalmente, en la figura que se muestra a continuación podemos observar como en Asia la mayoría de los encuestados tienen el grado de licenciado seguido por el de maestro. Por otro lado, Europa parece ser el continente con mayor cantidad de personas con doctorado y Australia el que cuenta con menos.

![educont](https://github.com/david-mcampa/AnalisisCorrespondenciaOcupacionLaboralTI/assets/74944322/db344975-6b6a-4388-929f-af10cc6aa008)

## Análisis de Correspondencia

La relación entre nivel de estudios y puestos de trabajo se muestra a continuación. El ajuste fue muy bueno pues la inercia de la primera dimensión es de 83.01% y de la segunda 16.62%.

![EstTrab](https://github.com/david-mcampa/AnalisisCorrespondenciaOcupacionLaboralTI/assets/74944322/2f4cc13f-a5be-4a14-b9db-0fd32ee1d7c3)

Para comprender mejor el comportamiento podemos obtener las contribuciones de cada variable, es decir, de cada puesto de trabajo a la inercia total. Estas contribuciones se muestra en la siguiente tabla:

|                     | **Dim1**      | **Dim2**      |
|---------------------|---------------|---------------|
| Business Analyst    | 0.00011570089 | 0.1701232122  |
| Currently not employed | 0.01567720658 | 0.0099307808  |
| Data Analyst        | 0.00333737635 | 0.0747554820  |
| Data Engineer       | 0.00003459838 | 0.0891156595  |
| Data Scientist      | 0.02635955702 | 0.1042831648  |
| DBA/Database Engineer | 0.00179736747 | 0.0304740264  |
| Machine Learning Engineer | 0.00129641354 | 0.0099915201  |
| Other               | 0.00626869550 | 0.0092629457  |
| Product/Project Manager | 0.00291734504 | 0.1626433106  |
| Research Scientist  | 0.76379578606 | 0.2480731774  |
| Software Engineer   | 0.01592337954 | 0.0005415819  |
| Statistician        | 0.10617444497 | 0.0085403339  |
| Student             | 0.05630212866 | 0.0822648047  |

Como podemos observar en la primera dimensión las variables con valores más grandes son el Research Scientist, Statistician y Student, lo que nos indica que esta dimensión está relacionado con los puestos académicos mientras que en la segunda dimensión los demas cargos laborales tienen contribuciones similares indicando que esta está relacionada con los puestos en la industria. 

Este análisis se confirma observando la Figura anterior pues el Research Scientist y el Statistician están corridos a la derecha y en el cuadrante inferior mientras que los demás están en cuadrantes superiores y entre izquierda y el centro. 

Para conocer que lenguajes de programación son los más requeridos y empleados en trabajos de ciencia y análisis de datos se realizó el respectivo análisis de correspondencia obteniendo la gráfica que se muestra en la siguiente figura. De igual manera el ajuste fue bueno pues la inercia de la primera dimensión fue 49.66% y de la segunda 28.93%.

![progtrab](https://github.com/david-mcampa/AnalisisCorrespondenciaOcupacionLaboralTI/assets/74944322/83f402f7-1c3c-4687-a8ea-9e66c4d3478e)

Las contribuciones de cada variable se muestran en la siguiente tabla

|                         | **Dim1**       | **Dim2**       |
|-------------------------|----------------|----------------|
| Business Analyst        | 0.121500875    | 0.00663953260  |
| Currently not employed | 0.004110702    | 0.00408931319  |
| Data Analyst            | 0.134998507    | 0.00195008810  |
| Data Engineer           | 0.029844556    | 0.12909842706  |
| Data Scientist          | 0.101469566    | 0.00213519810  |
| DBA/Database Engineer   | 0.048219153    | 0.19849516720  |
| Machine Learning Engineer | 0.022331078 | 0.00001612425  |
| Other                   | 0.014969033    | 0.00122519109  |
| Product/Project Manager | 0.002735575    | 0.01785095361  |
| Research Scientist      | 0.002426902    | 0.08266845245  |
| Software Engineer       | 0.075913584    | 0.21431415413  |
| Statistician            | 0.382833305    | 0.30410265538  |
| Student                 | 0.058647163    | 0.03741474287  |


Las variables con mayor contribución son Bussines Analyst, Data Analyst, Data Scientist y Statistician indicando que la primera dimensión está relacionada con los lenguajes de programación que se utilizan en el análisis y modelado de datos mientras que en la segunda dimensión las contribuciones más grandes son del Data Engineer, Database Engineer, Software Engineer y Statistician lo que indica que la segunda dimensión posiciona lenguajes de programación que están mas relacionados con el tratamiento, manejo y cuidado de los datos y no así con el análisis y creación de modelos.  

La relación que hay entre los salarios y el puesto de trabajo se muestra en la Figura(\ref{fig:saltrab}), obteniendo inercias de 48.48% y 20.12% para la primera y segunda dimensión respectivamente.

![saltrab](https://github.com/david-mcampa/AnalisisCorrespondenciaOcupacionLaboralTI/assets/74944322/9bd69088-81b4-489c-a2ed-1827186ca0bc)

Se obtuvieron las contribuciones de cada variable que se muestran en la siguiente tabla.

|                         | **Dim1**       | **Dim2**       |
|-------------------------|----------------|----------------|
| Business Analyst        | 0.0043498111   | 0.09987482705 |
| Data Analyst            | 0.1504202165   | 0.00510424196 |
| Data Engineer           | 0.0897151359   | 0.08491728302 |
| Data Scientist          | 0.0925140780   | 0.02071890014 |
| DBA/Database Engineer   | 0.0026685898   | 0.24847867427 |
| Machine Learning Engineer | 0.0776298188 | 0.21287381025 |
| Other                   | 0.0002044494   | 0.01078357075 |
| Product/Project Manager | 0.4072670888   | 0.00038042395 |
| Research Scientist      | 0.0010140271   | 0.00001248078 |
| Software Engineer       | 0.0430051429   | 0.02865608895 |
| Statistician            | 0.1312116417   | 0.28819969887 |


Analizando la Figura anterior, vemos que los salarios mas altos los tienen los Data Engineer con más de USD 500,000 al año, seguidos de los Data Scientist que perciben salarios intermedios altos, los salarios más bajos parecen arguparse al rededor de puestos como Software Engineer, Machine Learning Engineer y Reseach Scientist.

Por último obtuvimos del análisis de correspondencia entre los algoritmos más usados entre distintos tipos de trabajo que se muestra en la siguiente figura. De ajuste se obtuvieron inercia de la primera dimensión de 66.11% e inercia de la segunda con un valor de 26.11%

![algmltrab](https://github.com/david-mcampa/AnalisisCorrespondenciaOcupacionLaboralTI/assets/74944322/2d1faeb3-e2d9-4442-b3ae-67847c493373)

Las contribuciones de cada variable son las siguientes:

|                         | **Dim1**       | **Dim2**       |
|-------------------------|----------------|----------------|
| Business Analyst        | 0.1727401513   | 0.00153162565 |
| Currently not employed | 0.0237756922   | 0.02455495070 |
| Data Analyst            | 0.1569345357   | 0.00128603824 |
| Data Engineer           | 0.0020262588   | 0.01543539346 |
| Data Scientist          | 0.0002879951   | 0.48547637513 |
| DBA/Database Engineer   | 0.0690589613   | 0.00001428952 |
| Machine Learning Engineer | 0.2088022526 | 0.03416192614 |
| Other                   | 0.0412110721   | 0.01113235581 |
| Product/Project Manager | 0.0040977282   | 0.00699294696 |
| Research Scientist      | 0.0599385658   | 0.03463974778 |
| Software Engineer       | 0.0173911908   | 0.06812644249 |
| Statistician            | 0.2421075675   | 0.08974809563 |
| Student                 | 0.0016280285   | 0.22689981249 |


Podemos observar en la Figura anterior que los Machine Learning Engineer, Research Scientist y Software Engineer suelen usar algoritmos de aprendizaje profundo mientras que los demás puestos laborales usan algoritmos mas clásicos como regresiones, enfoques bayesianos y random forest. Los Data Scientist tienen como algoritmo más cercano a los métodos de Gradient Boosting. Entonces podemos decir que distintos cargos usan en general distintos métodos.

## Conclusiones

* La mayoría de los cargos ocupados en el área industrial (Data Scientist, Machine Learning Engineer, Data Analyst, etc.) requieren tener estudios hasta el grado de maestría. Por otro lado, para realizar investigación científica se requiere tener estudios hasta el grado de un doctorado. 
* La mayoría de los cargos relacionados al modelado de datos requieren el uso de herramientas computacionales como R, Python, Julia y SQL. Por otro lado, los cargos relacionados al área de manejo y tratamiento de datos usan herramientas como Java, C, C++, Matlab, entre otros.
* Los cargos con mejores retribuciones salariales las tienen Data Engineer, seguido de Data Scientist. Por otro lado, el AC muestra que los cargos con peores retribuciones salariales son Machine Learning Engineer, Data Analyst y Research Scientist.
* El puesto de Data Scientist tiene como algoritmo más cercano, el Gradient Boosting Machines. Por otro lado, los trabajadores que ocupan puestos como Machine Learning Engineer y Research Scientist suelen usar algoritmos de deep learning, como RNN, DNN y CNN. Finalmente, en puestos como Data Engineer o Data Analyst se usan algoritmos de clasificación y/o predicción como lo son Random Forests, Linear and Logistic Regression.
* Finalmente, podemos concluir que en puestos de trabajo con demanda creciente actualmente, como Data Scientist, se usan con mayor frecuencia programas computacionales como   R, Python, Julia y SQL. De igual forma, este tipo de empleos (Data Scientist y Data Engineer) tienen buenas retribuciones económicas. También es muy recomendable aprender las bases teóricas y prácticas de algoritmos como Gradient Boosting Machines ya que se usan con frecuencia en este tipo de empleos. Otro aspecto importante para tener éxito en esta área es el de contar con un grado de maestría.











