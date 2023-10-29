import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.sql import func

def actualizarTablaDimension(engine, table, data, pk="id"):
    """
    Esta función actualiza una tabla de dimensión de un DW con los datos nuevos. Si los datos
    ya existen en la tabla, no se agregan. Devuelve la tabla actualizada con los pk tal cual esta
    en la base de datos.

    La tabla de dimensión debe estar creada y las columnas deben llamarse igual que en el df.

    Parametros:
        engine: engine de la base de datos
        table: nombre de la tabla
        data: datafarme de datos nuevos a agregar, sin incluir la PK
        pk: nombre de la PK. Por defecto es "ID"

    Retorno:
        dimension_df: datafarme con la tabla según está en la DB con los datos nuevos agregados.

    """
    with engine.connect() as conn, conn.begin():
        old_data = pd.read_sql_table(table, conn)

        # Borro la columna pk
        old_data.drop(pk, axis=1, inplace=True)

        # new_data es el datafarme de datos diferencia de conjunto con old_data
        new_data = data[~data.stack().isin(old_data.stack().values).unstack().astype(bool)].dropna()

        # insertar new_data
        new_data.to_sql(table, conn, if_exists='append', index=False)

        # buscar como quedó la tabla
        dimension_df = pd.read_sql_table(table, conn)

    return dimension_df

#Leo los csv
df_juegos = pd.read_csv("./DataSets/games.csv")
print(df_juegos.head())