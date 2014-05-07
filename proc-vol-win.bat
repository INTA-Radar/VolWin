@echo off

rem Reemplazar la palabra "Directorio" por el camino donde están
rem los archivos de volúmenes (.vol)
rem Replace the word "Directorio" with the path where are the .vol file

FOR %%f in (C:\Directorio\*.vol) DO python vol.py %%f
