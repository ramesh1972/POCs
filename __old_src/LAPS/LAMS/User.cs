using System;
using System.Collections.Generic;
using System.Text;

namespace LAPS.LAMS
{
    public class User
    {
        static public int CheckIfEmailExists(string email)
        {
            LAPS.DataLayer.DataSets.UsersTableAdapters.UsersTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UsersTableAdapter();
            return (int)adp.CheckEmail(email);;
        }

        private Guid usrGUID;
        private Guid accGUID;
        private Guid usrInfoGUID;

        public Guid UserGUID
        {
            get
            {
                return usrGUID;
            }
        }

        public Guid AccountGUID
        {
            get
            {
                return accGUID;
            }
        }

        public Guid UserInfoGUID
        {
            get
            {
                return usrInfoGUID;
            }
        }

        public bool CreateNewAccount(string email, string password)
        {
            Guid UsrID = Guid.NewGuid();

            try
            {
                LAPS.DataLayer.DataSets.UsersTableAdapters.UsersTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UsersTableAdapter();
                adp.InsertOnEmailAddress(UsrID, (int)LAPS.LAMS.Globals.UserTypes.E_Customer, email);

                // -- create the main accont with the password
                LAPS.DataLayer.DataSets.UsersTableAdapters.UserAccountsTableAdapter acc_adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UserAccountsTableAdapter();
                Guid AccID = Guid.NewGuid();
                acc_adp.InsertQuery(AccID, UsrID, password, DateTime.Now);

                usrGUID = UsrID;
                accGUID = AccID;

                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool CheckValidAccount(string email, string password)
        {
            try
            {
                // get the UsrID based on the password
                LAPS.DataLayer.DataSets.UsersTableAdapters.UsersTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UsersTableAdapter();
                LAPS.DataLayer.DataSets.Users.UsersDataTable ur = adp.GetUserOnEmailAddress(email);
                if (ur == null)
                    return false;

                if (ur.Rows.Count != 1)
                    return false;

                LAPS.DataLayer.DataSets.Users.UsersRow urow = (LAPS.DataLayer.DataSets.Users.UsersRow) ur.Rows[0];
                Guid usr_guid = urow.UserGUID;

                // query the userinfo table for the password and user_guid
                LAPS.DataLayer.DataSets.UsersTableAdapters.UserAccountsTableAdapter acc_adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UserAccountsTableAdapter();
                LAPS.DataLayer.DataSets.Users.UserAccountsDataTable uar = acc_adp.GetAccount(password, usr_guid);

                if (uar == null)
                    return false;

                if (uar.Rows.Count != 1)
                    return false;

                // the user has valid login credentials                
                usrGUID = usr_guid;
                accGUID = ((LAPS.DataLayer.DataSets.Users.UserAccountsRow)uar.Rows[0]).AccountGUID;
                return true;
            }
            catch
            {
                return false;
            }
        }

        public LAPS.DataLayer.DataSets.Users.UsersRow GetUserInfo(Guid usrGuid)
        {
            try
            {
                LAPS.DataLayer.DataSets.UsersTableAdapters.UsersTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UsersTableAdapter();
                LAPS.DataLayer.DataSets.Users.UsersDataTable udt = adp.GetUserInfo(usrGuid);
                if (udt.Rows.Count != 1)
                    return null;

                return (LAPS.DataLayer.DataSets.Users.UsersRow) udt.Rows[0];
            }
            catch
            {
                return null;
            }
        }

        public LAPS.DataLayer.DataSets.Users.AddressesRow GetAddressInfo(Guid usrGuid)
        {
            try
            {
                Guid addGuid = GetAddressInfoGUID(usrGuid);
                if (addGuid == Guid.Empty)
                    return null;

                LAPS.DataLayer.DataSets.UsersTableAdapters.AddressesTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.AddressesTableAdapter();
                LAPS.DataLayer.DataSets.Users.AddressesDataTable adt = adp.GetAddressInfo(addGuid);

                if (adt.Rows.Count != 1)
                    return null;

                return (LAPS.DataLayer.DataSets.Users.AddressesRow)adt.Rows[0];
            }
            catch
            {
                return null;
            }
        }

        public LAPS.DataLayer.DataSets.Users.IdentityInfoDataTable GetIdentityInfo(Guid usrGuid)
        {
            try
            {
                Guid user_info_guid = GetSetUserInfoGUID(usrGuid);
                LAPS.DataLayer.DataSets.UsersTableAdapters.IdentityInfoTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.IdentityInfoTableAdapter();

                LAPS.DataLayer.DataSets.Users.IdentityInfoDataTable idt = adp.GetIdentityInfo(user_info_guid);
                
                return idt;
            }
            catch
            {
                return null;
            }
        }

        public LAPS.DataLayer.DataSets.Users.EmploymentInfoRow GetEmploymentInfo(Guid usrGuid)
        {
            try
            {
                Guid empGuid = GetEmpInfoGUID(usrGuid);
                if (empGuid == Guid.Empty)
                    return null;

                LAPS.DataLayer.DataSets.UsersTableAdapters.EmploymentInfoTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.EmploymentInfoTableAdapter();
                LAPS.DataLayer.DataSets.Users.EmploymentInfoDataTable edt = adp.GetUserEmpInfo(empGuid);

                if (edt.Rows.Count != 1)
                    return null;

                return (LAPS.DataLayer.DataSets.Users.EmploymentInfoRow) edt.Rows[0];
            }
            catch
            {
                return null;
            }
        }

        public LAPS.DataLayer.DataSets.Users.BankInfoRow GetBankInfo(Guid usrGuid)
        {
            try
            {
                Guid bankGuid = GetBankInfoGUID(usrGuid);
                if (bankGuid == Guid.Empty)
                    return null;

                LAPS.DataLayer.DataSets.UsersTableAdapters.BankInfoTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.BankInfoTableAdapter();
                LAPS.DataLayer.DataSets.Users.BankInfoDataTable edt = adp.GetUserBankInfo(bankGuid);

                if (edt.Rows.Count != 1)
                    return null;

                return (LAPS.DataLayer.DataSets.Users.BankInfoRow)edt.Rows[0];
            }
            catch
            {
                return null;
            }
        }

        public LAPS.DataLayer.DataSets.Users.ReferencesDataTable GetReferenceInfo(Guid usrGuid)
        {
            try
            {
                Guid user_info_guid = GetSetUserInfoGUID(usrGuid);
                LAPS.DataLayer.DataSets.UsersTableAdapters.ReferencesTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.ReferencesTableAdapter();

                LAPS.DataLayer.DataSets.Users.ReferencesDataTable idt = adp.GetReferenceInfo(user_info_guid);

                return idt;
            }
            catch
            {
                return null;
            }
        }

        public bool SaveUser(string FirstName, string MiddleName, string LastName, System.Nullable<System.DateTime> UserDOB, string TelephoneNo, string MobileNo, string Title, string FaxNo, string TimeToCallFrom, string TimeToCallTo, System.Guid UserGUID) 
        {
            LAPS.DataLayer.DataSets.UsersTableAdapters.UsersTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UsersTableAdapter();
            int ret = adp.SaveUser(FirstName, MiddleName, LastName, UserDOB, TelephoneNo, MobileNo, Title, FaxNo, TimeToCallFrom, TimeToCallTo, UserGUID);
            if (ret > 0)
                return true;

            return false;
        }

        public bool InsertAddress(Guid usrGuid, string BuildingName, string BuildingNo, string FlatNo, string Street, string PostalTown, string PostalCode, string County, string OwnOrRent, System.Nullable<int> DurationYears, System.Nullable<int> DurationsMonths)
        {
            // check if there is a row in the UserINfo table for the user already
            Guid userInfoGuid = GetSetUserInfoGUID(usrGuid);

            LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter();
            
            // Insert the Address Info Guid
            Guid AddGuid = Guid.NewGuid();
            adp.UpdateAddressInfoGUID(AddGuid, userInfoGuid);
            
            // Insert the address details
            LAPS.DataLayer.DataSets.UsersTableAdapters.AddressesTableAdapter add = new LAPS.DataLayer.DataSets.UsersTableAdapters.AddressesTableAdapter();
            add.InsertAddress(AddGuid, BuildingName, BuildingNo, FlatNo, Street, PostalTown, PostalCode, County, OwnOrRent, DurationYears, DurationsMonths);

            return true;
       }

        public bool InsertIdentityNo(System.Guid UserInfoGUID, string IdentityNumberName, string IdentityNo)
        {
            LAPS.DataLayer.DataSets.UsersTableAdapters.IdentityInfoTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.IdentityInfoTableAdapter();
            adp.InsertIdentityNo(UserInfoGUID, IdentityNumberName, IdentityNo);

            return true;
        }

        public bool InsertEmploymentInfo(System.Guid usrGUID, string SourceOfIncome, System.Nullable<float> PayPerCheque, string PayDirectDeposit, string FrequenceOfWage, string EmploymentType, System.Nullable<System.DateTime> NextPayDate, System.Nullable<System.DateTime> FollowingPayDate, string CompanyName, string Department, string PostHeld, string SupervisorName, string CompanyMainNo, int DurationYears, int DurationMonths)
        {
            Guid userInfoGuid = GetSetUserInfoGUID(usrGUID);

            // Insert the Employment Info Guid
            Guid EmpGuid = Guid.NewGuid();
            LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter();
            adp.UpdateEmploymentInfoGUID(EmpGuid, UserInfoGUID);
            
            LAPS.DataLayer.DataSets.UsersTableAdapters.EmploymentInfoTableAdapter eadp = new LAPS.DataLayer.DataSets.UsersTableAdapters.EmploymentInfoTableAdapter();
            eadp.InsertEmploymentInfo(EmpGuid, SourceOfIncome, PayPerCheque, PayDirectDeposit, FrequenceOfWage, EmploymentType, NextPayDate, FollowingPayDate, CompanyName, Department, PostHeld, SupervisorName, CompanyMainNo, DurationYears, DurationMonths);
            
            return true;
        }

        public bool InsertBankInfo(System.Guid usrGuid, string SocAccountNo, string BranchSortCode) 
        {
            Guid userInfoGuid = GetSetUserInfoGUID(usrGuid);

            // Insert the Employment Info Guid
            Guid BankGuid = Guid.NewGuid();
            LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter();
            adp.UpdateBankInfoGUID(BankGuid, UserInfoGUID);

            LAPS.DataLayer.DataSets.UsersTableAdapters.BankInfoTableAdapter
                 eadp = new LAPS.DataLayer.DataSets.UsersTableAdapters.BankInfoTableAdapter();
            eadp.InsertBankInfo(BankGuid, SocAccountNo, BranchSortCode);

            return true;
        }

        public bool InsertReferenceInfo(System.Guid MainUsrGUID, string ReferenceRelation, string ReferenceName) 
        {
            Guid userInfoGuid = GetSetUserInfoGUID(MainUsrGUID);

            // create a new user in the system as a reference
            Guid usrGuid = Guid.NewGuid();
            LAPS.DataLayer.DataSets.UsersTableAdapters.UsersTableAdapter uadp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UsersTableAdapter();
            uadp.InsertOnName(usrGuid, (int)LAPS.LAMS.Globals.UserTypes.E_Reference, ReferenceName);

            // Insert the Employment Info Guid
            LAPS.DataLayer.DataSets.UsersTableAdapters.ReferencesTableAdapter
                 eadp = new LAPS.DataLayer.DataSets.UsersTableAdapters.ReferencesTableAdapter();
            eadp.InsertReferenceInfo(userInfoGuid, ReferenceRelation, usrGuid);

            return true;
        }

        private Guid GetUserInfoGuid(Guid usrGuid)
        {
            LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter();
            LAPS.DataLayer.DataSets.Users.UserInfoDataTable uinf = adp.GetUserInfoGUID(usrGuid);
            LAPS.DataLayer.DataSets.Users.UserInfoRow uinfrow = (LAPS.DataLayer.DataSets.Users.UserInfoRow)uinf.Rows[0];

            return uinfrow.UserInfoGUID;
        }

        public Guid GetSetUserInfoGUID(Guid usrGuid)
        {
            Guid userInfoGuid;
            LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter();
            int cnt = (int) adp.CheckUserInfoGUID(usrGuid);
            if (cnt == 0)
            {
                userInfoGuid = Guid.NewGuid();
                adp.InsertUserInfoGUID(userInfoGuid, usrGuid);
            }
            else
            {
                // get the Guid
                userInfoGuid = GetUserInfoGuid(usrGuid);
            }

            usrInfoGUID = userInfoGuid;
            return userInfoGuid;
        }

        public Guid GetAddressInfoGUID(Guid usrGuid)
        {
            Guid user_info_guid = GetSetUserInfoGUID(usrGuid);
            LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter();
            LAPS.DataLayer.DataSets.Users.UserInfoDataTable uinf = adp.GetAddressInfoGUID(user_info_guid);
            LAPS.DataLayer.DataSets.Users.UserInfoRow uinfrow = (LAPS.DataLayer.DataSets.Users.UserInfoRow)uinf.Rows[0];
            try { return uinfrow.AddressInfoGUID; }
            catch {return Guid.Empty;}
        }

        public Guid GetEmpInfoGUID(Guid usrGuid)
        {
            Guid user_info_guid = GetSetUserInfoGUID(usrGuid);
            LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter();
            LAPS.DataLayer.DataSets.Users.UserInfoDataTable uinf = adp.GetEmpInfoGuid(user_info_guid);
            LAPS.DataLayer.DataSets.Users.UserInfoRow uinfrow = (LAPS.DataLayer.DataSets.Users.UserInfoRow)uinf.Rows[0];
            try { return uinfrow.WorkInfoGUID; }
            catch { return Guid.Empty; }
        }

        public Guid GetBankInfoGUID(Guid usrGuid)
        {
            Guid user_info_guid = GetSetUserInfoGUID(usrGuid);
            LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter adp = new LAPS.DataLayer.DataSets.UsersTableAdapters.UserInfoTableAdapter();
            LAPS.DataLayer.DataSets.Users.UserInfoDataTable uinf = adp.GetBankInfoGuid(user_info_guid);
            LAPS.DataLayer.DataSets.Users.UserInfoRow uinfrow = (LAPS.DataLayer.DataSets.Users.UserInfoRow)uinf.Rows[0];
            try { return uinfrow.BankInfoGUID; }
            catch { return Guid.Empty; }
        }
    }
}
