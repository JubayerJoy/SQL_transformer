# LLM based Question and Answer System for SQL Database

## Project Highlights

- We will build an LLM based question and answer system that will use following,
  - Open AI LLM
  - Hugging face embeddings
  - Streamlit for UI
  - Langchain framework
  - Chromadb as a vector store
  - Few shot learning
- In the UI, store manager will ask questions in a natural language and it will produce the answers

## Installation

1. Install the required dependencies using pip:

```bash
  pip install -r requirements.txt
```

2. Acquire an api key through OPEN AI and put it in .env file

```bash
  OPENAI_API_KEY="your_api_key_here"
```

3. Start the MySQL server and run the migration and seed files to create the database and populate it with data.

```bash
  mysql -u root -p
  source database/db_ecommerce_store.sql
```

## Usage

1. Run the Streamlit app by executing:

```bash
streamlit run main.py

```

2. The web app will open in your browser where you can ask questions

## Sample Questions

- How many total t shirts are left in total in stock?
- How many t-shirts do we have left for Easy in XS size and white color?
- How much is the total price of the inventory for all S-size t-shirts?
- How much sales amount will be generated if we sell all small size Cats eye shirts today after discounts?

## Project Structure

- main.py: The main Streamlit application script.
- langchain_helper.py: This has all the langchain code
- requirements.txt: A list of required Python packages for the project.
- few_shots.py: Contains few shot prompts
- .env: Configuration file for storing your OPEN AI API key.
