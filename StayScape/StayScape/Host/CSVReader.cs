using Microsoft.VisualBasic.FileIO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StayScape
{
    public class CSVReader
    {
        public static void ProcessCSV(string filePath, Action<string[]> processRow)
        {
            using (TextFieldParser parser = new TextFieldParser(filePath))
            {
                parser.TextFieldType = FieldType.Delimited;
                parser.SetDelimiters(",");

                // Skip header row if present
                if (!parser.EndOfData)
                {
                    parser.ReadLine(); // Skip header row
                }

                // Read and process each row of data
                while (!parser.EndOfData)
                {
                    string[] fields = parser.ReadFields();
                    if (fields != null)
                    {
                        // Process the fields
                        processRow(fields);
                    }
                }
            }
        }
    }
}