﻿using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StayScape
{
    public class DBManager
    {
        private string connectionString =
            ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
        SqlConnection connection;


        public SqlCommand ExecuteQuery(string query, SqlParameter[] parameters = null)
        {

            SqlCommand command = new SqlCommand(query, connection);

            if (parameters != null)
            {
                command.Parameters.AddRange(parameters);
            }

            return command;


        }

        public int ExecuteScalar(string query, SqlParameter[] parameters = null)
        {

            SqlCommand command = new SqlCommand(query, connection);

            if (parameters != null)
            {
                command.Parameters.AddRange(parameters);
            }

            return (int)command.ExecuteScalar();
        }

        public Boolean ExecuteNonQuery(string nonQuery, SqlParameter[] parameters = null)
        {

            SqlCommand command = new SqlCommand(nonQuery, connection);

            if (parameters != null)
            {
                command.Parameters.AddRange(parameters);
            }

            return command.ExecuteNonQuery() > 0 ? true : false;
        }

        public void createConnection()
        {
            try
            {
                connection = new SqlConnection(connectionString);
                connection.Open();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        public void closeConnection()
        {
            connection.Close();
        }
    }
}