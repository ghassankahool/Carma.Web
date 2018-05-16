using System;
using System.Net;
using System.Web.Http;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web.Hosting;

public class UploadController : ApiController
{
    // POST api/<controller>
    [HttpPost]
    public IHttpActionResult Post([FromBody]uploadModel value)
    {
        if (string.IsNullOrEmpty(value.ID))
            return Content(HttpStatusCode.BadRequest, "Error!");

        byte[] imageBytes = Convert.FromBase64String(value.ID);
        var ms = new MemoryStream(imageBytes, 0, imageBytes.Length);

        // Convert byte[] to Image
        ms.Write(imageBytes, 0, imageBytes.Length);
        var image = Image.FromStream(ms, true);

        string newFile = string.Format("{0}.jpg", Guid.NewGuid()),
               path = HostingEnvironment.MapPath("~/Public/images/"),
               filePath = Path.Combine(path, newFile);

        try
        {
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            image.Save(filePath, ImageFormat.Jpeg);

            // Save Thumb image //////////////////////////////////
            // Set image height and width to be loaded on web page
            byte[] buffer = getResizedImage(filePath, 150, 150);
            // prepaire thumb folder
            string pPath = Path.Combine(path, "_thumb\\");
            if (!Directory.Exists(pPath))
            {
                Directory.CreateDirectory(pPath);
            }
            // save image in thumb folder
            File.WriteAllBytes(pPath + newFile, buffer);
            // end ///////////////////////////////////////////////

            return Ok(newFile);
        }
        catch (Exception ex)
        {
            return Content(HttpStatusCode.BadRequest, "Error!" + ex.Message);
        }
    }

    byte[] getResizedImage(String path, int width, int height)
    {
        var imgIn = new Bitmap(path);
        double y = imgIn.Height;
        double x = imgIn.Width;

        double factor = 1;
        if (width > 0)
        {
            factor = width / x;
        }
        else if (height > 0)
        {
            factor = height / y;
        }

        var outStream = new MemoryStream();
        var imgOut = new Bitmap((int)(x * factor), (int)(y * factor));

        // Set DPI of image (xDpi, yDpi)
        imgOut.SetResolution(96, 96); //72, 72);

        Graphics g = Graphics.FromImage(imgOut);
        g.Clear(Color.White);
        g.DrawImage(imgIn, new Rectangle(0, 0, (int)(factor * x), (int)(factor * y)),
          new Rectangle(0, 0, (int)x, (int)y), GraphicsUnit.Pixel);

        imgOut.Save(outStream, getImageFormat(path));
        outStream.Flush();
        outStream.Close();
        outStream.Dispose();
        return outStream.ToArray();
    }

    string getContentType(String path)
    {
        switch (Path.GetExtension(path))
        {
            case ".bmp": return "Image/bmp";
            case ".gif": return "Image/gif";
            case ".jpg": return "Image/jpeg";
            case ".png": return "Image/png";
            default: break;
        }
        return "";
    }

    ImageFormat getImageFormat(String path)
    {
        switch (Path.GetExtension(path))
        {
            case ".bmp": return ImageFormat.Bmp;
            case ".gif": return ImageFormat.Gif;
            case ".jpg":
            case ".jpeg": return ImageFormat.Jpeg;
            case ".png": return ImageFormat.Png;
            default: break;
        }
        return ImageFormat.Jpeg;
    }
}

public class uploadModel
{
    public string[] Name { get; set; } = { };
    public string ID { get; set; } = "0";
}
