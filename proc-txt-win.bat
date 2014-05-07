@echo off

rem recibe como parametro el directorio donde va a generar el archivo shape de puntos.

rem Pasa como primer parametros el archivo .txt para procesar
rem Pasa como segundo parámetro el directorio donde va a generar el archivo shape de puntos.
rem Reemplazar la palabra "Directorio" por el camino donde se encuetran los archivos txt


FOR %%f in (D:\Directorio\*.txt) do procesarwin.bat %%f %1

