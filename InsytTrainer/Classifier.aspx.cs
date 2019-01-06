using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using InsytTrainer.Models;
using Microsoft.AspNet.Identity;
using Newtonsoft.Json;

namespace InsytTrainer
{
    public partial class Classifier : System.Web.UI.Page
    {
        List<Word> _Words = new List<Word>();
        List<VaderClassification> Done = new List<VaderClassification>();       
        int count = 0;
        string dataFolder;
        string countFilePath;
        string resultFilePath;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
            }
            else
            {

                if (!IsPostBack)
                {
                    dataFolder = Server.MapPath("~/Data");


                    var username = User.Identity.GetUserName();
                    resultFilePath = Server.MapPath("~/Data/" + username + "result.txt");
                    countFilePath = Server.MapPath("~/Data/" + username + "count.txt");


                    _Words = JsonConvert.DeserializeObject<List<Word>>(File.ReadAllText(Path.Combine(dataFolder, "JsonWords.txt")));

                    if (File.Exists(resultFilePath))
                    {
                        Done = JsonConvert.DeserializeObject<List<VaderClassification>>(File.ReadAllText(resultFilePath));
                    }
                    else
                    {
                        foreach (var item in _Words)
                        {
                            Done.Add(new VaderClassification() { Word = item.dWord, Value = null });
                        }
                    }

                    if (File.Exists(countFilePath))
                    {
                        count = int.Parse(File.ReadAllText(countFilePath));
                        litCount.Text = count.ToString();
                    }
                    else
                    {
                        count = 0;
                        litCount.Text = count.ToString();
                        File.WriteAllText(countFilePath, count.ToString());
                    }

                    Session["count"] = count;
                    Session["resultPath"] = resultFilePath;
                    Session["countPath"] = countFilePath;
                    Session["words"] = _Words;
                    Session["done"] = Done;

                    Display(count);
                }
                else
                {
                    
                    resultFilePath = Session["resultPath"].ToString();
                    countFilePath = Session["countPath"].ToString();
                    _Words = (List<Word>)Session["words"];
                    Done = (List<VaderClassification>)Session["done"];

                    count = Convert.ToInt32(Session["count"]);
                }
            }
            
            //var filePath = Server.MapPath("~") + @"JsonWords.json";

            ////var file = File.ReadAllLines(filePath);


            //try
            //{
            //    var pidginWords = JsonConvert.DeserializeObject<List<jsonPidginWords>>(File.ReadAllText(filePath));


            //}
            //catch (Exception)
            //{
            //    throw;

            //}

        }

        private void Display(int index)
        {
            Session["count"] = index;
            Session["done"] = Done;

            var curWord = _Words[index];
            var curClass = Done[index];

            litCount.Text = index.ToString();
            lblExample.Text = curWord.Examples;
            lblMeaning.Text = curWord.Definitions;
            lblWord.Text = curWord.dWord;

            selectRad(curClass.Value);
        }

        private int? getRadValue()
        {
            int? rtn = null;
            if (rad0.Checked) rtn = 0;
            else if (rad1.Checked) rtn = 1;
            else if (rad2.Checked) rtn = 2;
            else if (rad3.Checked) rtn = 3;
            else if (rad4.Checked) rtn = 4;
            else if (rad1Neg.Checked) rtn = -1;
            else if (rad2Neg.Checked) rtn = -2;
            else if (rad3Neg.Checked) rtn = -3;
            else if (rad4Neg.Checked) rtn = -4;
            else rtn = null;

            return rtn;
        }

        private void selectRad(int? value)
        {
            switch (value)
            {
                case -4:
                    rad4Neg.Checked = true;
                    break;
                case -3:
                    rad3Neg.Checked = true;
                    break;
                case -2:
                    rad2Neg.Checked = true;
                    break;
                case -1:
                    rad1Neg.Checked = true;
                    break;
                case 0:
                    rad0.Checked = true;
                    break;
                case 1:
                    rad1.Checked = true;
                    break;
                case 2:
                    rad2.Checked = true;
                    break;
                case 3:
                    rad3.Checked = true;
                    break;
                case 4:
                    rad4.Checked = true;
                    break;
                default:
                    rad4.Checked = false;
                    rad3.Checked = false;
                    rad2.Checked = false;
                    rad1.Checked = false;
                    rad0.Checked = false;
                    rad1Neg.Checked = false;
                    rad2Neg.Checked = false;
                    rad3Neg.Checked = false;
                    rad4Neg.Checked = false;

                    break;
            }
        }




        //[WebMethod]
        //public static string GetWords()
        //{
        //var filePath = HttpContext.Current.Server.MapPath("~") + @"JsonWords.json";



        // var s =  File.ReadAllText(filePath);

        //JavaScriptSerializer sr = new JavaScriptSerializer
        //{
        //    MaxJsonLength = Int32.MaxValue
        //};

        //return  sr.Serialize(s);
        //}
        

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            var str = JsonConvert.SerializeObject(Done);
            File.WriteAllText(resultFilePath, str);

            File.WriteAllText(countFilePath, count.ToString());

            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
            authenticationManager.SignOut();
            Response.Redirect("~/Login.aspx");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {

            Done[count].Value = getRadValue();

            if (count < _Words.Count)
            {
                count++;
                Display(count);
            }
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            Done[count].Value = getRadValue();

            if (count > 0)
            {
                count--;
                Display(count);
            }
        }
    }
}