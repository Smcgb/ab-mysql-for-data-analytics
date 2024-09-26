import pandas as pd
import pymysql
import sqlalchemy as sql
from mypassword import password, user
import warnings

warnings.filterwarnings('ignore') # a future warning is thrown by pandas

conn = sql.create_engine(f"mysql+pymysql://{user}:{password}@localhost/wle")
cursor = conn.connect()

query = """SELECT * FROM worldlifeexpectancy"""

df = pd.read_sql(query, conn)
all_correlation = round(df['Lifeexpectancy'].corr(df['GDP']),2)

print(f'The correlation between GDP and Life Expectancy is {all_correlation} for all data points present')

correl_df = pd.DataFrame(columns=['Year', 'Correlation'])
for year in df['Year'].sort_values().unique():
    year_df = df[df['Year'] == year]
    correlation = round(year_df['Lifeexpectancy'].corr(year_df['GDP']), 2)
    correl_df = pd.concat([correl_df, pd.DataFrame({'Year': [year], 'Correlation': [correlation]})], ignore_index=True)
    print(f'The correlation between GDP and Life Expectancy is {correlation} for the year {year}')

# convert to csv
correl_df.to_csv('gdp_year.csv', index=False)

# free up resources
cursor.close()
conn.dispose()
