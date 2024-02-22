import streamlit as st
from langchain_helper import get_few_shot_db_chain

st.title("AI-Powered Data Retrieval: Leveraging Large Language Models for End-to-End Database Access with Attention to Data Security")

question = st.text_input("Question: ")

if question:
    chain = get_few_shot_db_chain()
    response = chain.run(question)

    st.header("Answer")
    st.write(response)






