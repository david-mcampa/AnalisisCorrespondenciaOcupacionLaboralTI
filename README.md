# Análisis de Correspondencia para Datos de Ocupación Laboral en la Industria TI

Utilizando el análisis de correspondencia, investigamos los requisitos educativos, las herramientas principales, y los salarios asociados a los roles relacionados 
al manejo de datos dentro de la Industria TI. Nuestros hallazgos revelan que una proporción significativa de los puestos laborales requieren un nivel de educación de maestría,
mientras que los puestos que implican investigación a menudo requieren cualificaciones superiores. Además, observamos que las herramientas utilizadas varían en función 
de áreas como el análisis y modelado de datos, el tratamiento y cuidado de datos, así como el desarrollo de software y el aprendizaje automático. En términos de remuneración, 
nuestro análisis indica que los puestos de procesamiento de datos tienen los salarios más altos, seguidos de los roles de análisis y modelado, mientras que los puestos de 
desarrollo de software e investigación tienden a tener salarios relativamente más bajos. Este análisis arroja luz sobre el panorama de los puestos en el modelado y 
manejo de datos en la industria global.

## Descripción de los datos
La base de datos \textit{kaggle\_survey\_2020\_responses.csv}, contiene las respuestas de los participantes de la encuesta de Kaggle, que incluyen información sobre su experiencia, habilidades, educación, empleo y otras áreas relacionadas con la ciencia de datos. Dicha base cuenta con más de 39 preguntas (columnas) y  y 20,036 respuestas (filas) por usuarios de diferentes partes del mundo. Algunas de las variables con la que cuenta la base son: 

\begin{itemize}
    \item Q$_{1}$: What is your age (\# years)?
    \item Q$_{2}$:  What is your gender? - Selected Choice
    \item Q$_{3}$: In which country do you currently reside?
    \item Q$_{4}$: What is the highest level of formal education that you have attained or plan to attain within the next 2 years?
    \item Q$_{5}$: Select the title most similar to your current role (or most recent title if retired): - Selected Choice
    \item  Q$_{8}$: What programming language would you recommend an aspiring data scientist to learn first? - Selected Choice
    \item Q$_{15}$: For how many years have you used machine learning methods? \\
     \vdots
\end{itemize}

Ahora bien, para tener un mejor entendimiento de la base aquí estudiada, a continuación se muestran algunas gráficas informativas. En la figura (\ref{fig:freqtrab}), el eje vertical corresponde a la variable Q$_{5}$, es decir, es el puesto que las personas creen que desempeñan de acuerdo a sus actividades asignadas. En dicha imágen podemos observar que el cargo más popular es el de científico de datos, le siguen ingeniero de software y analista de datos (esto sin contar a 'otros' y 'desempleados'). Este gráfico nos proporciona información sobre los puestos más populares que la gente cree ocupar en su trabajo.

\begin{figure}[H]
	\centering
	\includegraphics[width = 0.65\textwidth ]{trabajos.png}
	\caption{Puestos de trabajo considerados en la encuesta. Observamos que de entre los puestos incluidos en la encuesta, el de científico de datos es el  más popular de ellos.}
	\label{fig:freqtrab}
\end{figure}

En la figura (\ref{fig:freqtrabcont}) tenemos un gráfico de conteo de los puestos de trabajo por continente y separados por géneros masculino y femenino. En el gráfico podemos observar que la mayoría de los encuestados en el continente asiático  son estudiantes. Del mismo modo, en casi todos los continentes, el puesto de trabajo más popular es el de científico de datos (de acuerdo a la proporción de encuestados de cada país). Otra observación importante es que, las mujeres tienen menos presencia para los mismos puestos que los hombres. 

\begin{figure}[H]
	\centering
	\includegraphics[width = \textwidth ]{trabajoscont.png}
	\caption{Gráfico de conteo de los puestos de trabajo por continente y separados por géneros.}
	\label{fig:freqtrabcont}
\end{figure}

Finalmente, en la figura (\ref{fig:freqestcont}) podemos observar como en Asia la mayoría de los encuestados tienen el grado de licenciado seguido por el de maestro. Por otro lado, Europa parece ser el continente con mayor cantidad de personas con doctorado y Australia el que cuenta con menos.
\begin{figure}[H]
	\centering
	\includegraphics[width = \textwidth ]{hola.png}
	\caption{Gráfico de conteo de los niveles de educación por continente y separados por géneros.}
	\label{fig:freqestcont}
\end{figure}

