El frontend está hecho con React.js
La mayoría de las depencias son visuales
Las dependencias no visuales:
    1) Axios para mandar requests al api
    2) CORS para poder trabajar sin problemas con el API
    3) date-fns: permite ver formatos de fecha cuando se usan los calendarios
    4) dotenv: variables de ambiente que guardan host y puertos
    5) Formik: facilita la creación de forms
    6) Moment y Luxon: librerías para datetime
    7) Universal Cookie: uso de cookies para guardar información pertinente al usuario
    8) Yup: ayuda para la validación de la información de los forms; revisar si está vacía o no

*** Estilos ***
Para definir la estética global de la aplicación, se tiene el archivo "GlobalStyles.js", donde se definen los colores, dimensiones, etc., de varios componentes.
Los valores de la estética se extraen desde la carpeta "theme" 

En vez de tener un componente que llame a otros componentes, se tiene el archivo 'routes/routes.js' el cual hace un mapping de un componente padre con el componente hijo. El hijo define qué se visualiza en pantalla, al igual que definir cuál es el url que se usa para llegar a ese componente.

*** Tablas ***
Asimismo, para ser capaces de mostrar las tablas, se utiliza una clase de @mui llamada DataGrid, al cual se le definen los headers de la tabla, y se le pasa un objeto por parámetro, y así va haciendo un mapping del objeto a la columna correspondiente.

*** Popup ***
Cada vez que una página tiene un popup, es porque existe este componente en la subcarpeta de componentes correspondiente a esa página. Este popup se incluye dentro del JSX del componente
padre, y, dado un evento dado, el atributo setOpenPopup={setOpenPopup} del popup se pone el true, lo cual muestra esta ventana en pantalla.

*** Componentes de entries ***
Todas las subcarpetas de entries poseen cuatro archivos: el Popup, que se usa ya sea para insertar o actualizar datos, el form de incerción, form de actualización, y un componente que muestra en una tabla los datos de la base de datos.

*** Axios ***
Este permite hacer las llamadas al API, y las hace desde varios componentes. Todas las llamadas son del método "post" dado a su facilidad dentro del contexto de este proyecto, y tienen los headers correspondientes, que son los mismos descritos en el API.