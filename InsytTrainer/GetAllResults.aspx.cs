using Ionic.Zip;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InsytTrainer
{
    public partial class GetAllResults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          if (!IsPostBack)
            {
                GetFiles();
               
                GetUsers();
            }
        }

        private void GetFiles()
        {
            var filePaths = Directory.GetFiles(Server.MapPath("~/Data/")).Where(x => x.Contains("result"));
            List<ListItem> files = new List<ListItem>();

            foreach (string filePath in filePaths)
            {
                files.Add(new ListItem(Path.GetFileName(filePath), filePath));
            }

            GridView1.DataSource = files;
            GridView1.DataBind();

        }

        private void GetUsers()
        {
            using (var db = new IdentityDbContext())
            {
                
                var users = db.Users.ToList();
                List<ListItem> userList = new List<ListItem>();
                foreach (var user in users)
                {
                    userList.Add(new ListItem(user.UserName, user.UserName));
                }
                grdUsers.DataSource = userList;
                grdUsers.DataBind();
            }
        }


        
        protected void btnDownload_Click(object sender, EventArgs e)
        {
            using (ZipFile zip = new ZipFile())
            {
                zip.AlternateEncodingUsage = ZipOption.AsNecessary;
                zip.AddDirectoryByName("Data");
                foreach (GridViewRow row in GridView1.Rows)
                {
                    if ((row.FindControl("chkSelect") as CheckBox).Checked)
                    {
                        string filePath = (row.FindControl("lblFilePath") as Label).Text;

                        zip.AddFile(filePath, "Data");
                    }
                }
                Response.Clear();
                Response.BufferOutput = false;
                string zipName = String.Format("Zip_{0}.zip", DateTime.Now.ToString("yyyy-MMM-dd-HHmmss"));
                Response.ContentType = "application/zip";
                Response.AddHeader("content-disposition", "attachment; filename=" + zipName);
                zip.Save(Response.OutputStream);
                Response.End();
            }
        }

        protected void btnUsers_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in grdUsers.Rows)
            {
                if ((row.FindControl("chkSelectUser") as CheckBox).Checked)
                {
                    string username = (row.FindControl("lblUserName") as Label).Text;

                    var userStore = new UserStore<IdentityUser>();
                    var userManager = new UserManager<IdentityUser>(userStore);

                   var user = userManager.FindByName(username);

                    userManager.Delete(user);
                    GetUsers();
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                if ((row.FindControl("chkSelect") as CheckBox).Checked)
                {
                    string filePath = (row.FindControl("lblFilePath") as Label).Text;

                    var fi = new FileInfo(filePath);

                    fi.Delete();

                    GetFiles();
                }
            }
        }
    }
}