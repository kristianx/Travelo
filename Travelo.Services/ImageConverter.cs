using System;
using System.IO;

public class ImageConverter
{
    public byte[] ConvertImageToByteArray(string imagePath)
    {
        try
        {
            byte[] imageBytes = File.ReadAllBytes(imagePath);
            return imageBytes;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"An error occurred while converting the image to byte array: {ex.Message}");
            return null; // or throw an exception, depending on your use case
        }
    }
}