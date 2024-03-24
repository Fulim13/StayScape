using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace StayScape
{
    public class DBConnection
    {
        private string connectionString =
            ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
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
            connection = new SqlConnection(connectionString);
            connection.Open();
        }

        public void closeConnection()
        {
            connection.Close();
        }
    }
}