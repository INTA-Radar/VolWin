@echo off
rem !/bin/bash

rem Para hacer funcionar este proceso por lotes se deben instalar una serie de 
rem software, el detalle se puede encontrar en ......

rem recibe como parámetro el archivo de texto y donde crear el shape de los puntos

rem este set de archivos son necesarios para que este scrip funcione.  Se encuentran en un .zip en el repositorio Vol
set shp=puntos.shp
set csv=puntos.csv
set tmp=puntos.tmp
set tmp2=puntosf.tmp
set vrt=puntos.vrt

rem donde dice Directorio reemplazar por el camino de la carpeta donde se quieren almacenar los
rem archivos de imágenes
set dir_base=D:\Directorio\

rem donde dice Directorio reemplazar por el camino de la carpeta donde se quieren mover
rem los archivos de texto ya procesados
set dir_hechos=D:\Directorio\

rem Prepara el encabezado para el csv
echo lon,lat,dbz > %csv%

rem dumpea encabezado y datos reemplazando espacios por comas

rem type %csv% %dir_base%%1 | sed s/\s/,/gi > %tmp%
type %csv% %1 | sed s/\s/,/gi > %tmp%
type %tmp% > %csv%

echo Preparando datos...


echo Convirtiendo a shp...

ogr2ogr -f "ESRI Shapefile" %2 %vrt% -overwrite

rem Donde dice Directorio cambiar por el camino donde se copio el archivo template-grilla-TM-LIMPIA.tif
echo Crear imagen en blanco...
copy D:\Directorio\procesados\template-grilla-TM-LIMPIA.tif %1.tif

rem Rasterizar los puntos del barrido
echo Rasterizar los puntos del barrido
gdal_rasterize -ts 487 505 -a_nodata -99 -a dbz -l puntos ./%2/%shp% %1.tif

rem Suavizar la imagen
python completa-blancos.py %1.tif 2 max

rem cambia de disco los hechos
move %1 %dir_hechos%
