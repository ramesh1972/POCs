using System;
using System.Data;
using System.Data.OleDb;
using System.Collections; 

using GRAVE.Server; 
using GRAVE.Server.Entity.Definition; 
using GRAVE.Server.Entity.Implementation; 
using GRAVE.Server.Data;

namespace GRAVE
{
	namespace Server
	{
		public class CGRAVECodeParser
		{
			CEntityImpl ent_ref = null;
			int code_tag_openned = 0;

			public CGRAVECodeParser()
			{

			}

			public string ParseAndProcessCode(string gui_code, ref int index_of_at)
			{// takes care of @( and nesting
				CEntityImpl ent = null;
				return ParseAndProcessCode(gui_code, ref index_of_at, ref ent);
			}

			public string ParseAndProcessCode(string gui_code, ref int index_of_at, ref CEntityImpl ent)
			{// takes care of @(..code..)@ and nesting
				if (gui_code == "")
					return "";

				ent_ref = ent;

				// find the first occurance of @( and then pass in the index_of_at
				while (index_of_at >= 0 &&
						index_of_at < gui_code.Length)
				{
					// Check for any special entity related function calls
					char cchar = gui_code[index_of_at];

					int oindex = index_of_at;
					if (cchar == '@' && gui_code[index_of_at+1] == '(') 
					{// if this is the command or a sub command @(
						code_tag_openned++;
						gui_code = _ParseAndProcessCode(gui_code, ref index_of_at, ref ent);
						code_tag_openned--;							
					}
					else
						index_of_at++;

					// scan for next command
					if (index_of_at >= 0)
						index_of_at = gui_code.IndexOf("@(", index_of_at);
				}

				return gui_code;
			}

			private string _ParseAndProcessCode(string gui_code, ref int index_of_at, ref CEntityImpl ent)
			{
				int oindex = index_of_at;
				index_of_at+=2;

				gui_code = ScanCommandParamsAndExecute(gui_code, ref index_of_at, ref ent);

				gui_code = Utils.ReplaceString(gui_code, oindex, 2, ""); // -2 for @(
				gui_code = Utils.ReplaceString(gui_code, index_of_at-2,2, "");

				index_of_at-=2; // for removing the @()@ 

				return gui_code;
			}

			private string ScanCommandParamsAndExecute(string gui_code, ref int index, ref CEntityImpl ent)
			{
				if (gui_code == "")
					return "";

				if (index >= gui_code.Length)
					return gui_code;

				int oindex = index;
				char cchar = gui_code[index];

				while (true) // this will be end of @( command
				{
					// exit
					if (cchar == ')' && 
						(index < gui_code.Length-1 && gui_code[index+1] == '@'))
						break;

					// parse code inbetween..look for special commands
					if (code_tag_openned > 0)
					{
						if (cchar == '$') // if this is a $prop_name
						{
							gui_code = ScanDollarTokenAndExecute(gui_code, ref index, ref ent);
						}
						else if (cchar == '%') // then this is a specific X<command> on the local ucms entities db
						{
							if (gui_code[index+1] != '@' && 
								gui_code[index+1] != '>') // to avoid ASP.NET <%@Register ...%>
							{
								gui_code = ScanSpecialCommandAndExecute(gui_code, ref index, ref ent);
							}
							else
								index++;
						}
						else if  (cchar == '#') // then this is a specific X<command> on the local ucms db
						{
							gui_code = ScanSpecialCommandAndExecute(gui_code, ref index, ref ent);
						}
						else if (cchar == '@' && gui_code[index+1] == '(') // if this is the command or a sub command @(
						{
							code_tag_openned++;
							gui_code = ParseAndProcessCode(gui_code, ref index, ref ent);
							code_tag_openned--;
						}
					}	
					
					if (index >= 0 && index < gui_code.Length -1)
						cchar = gui_code[++index];
					else
						break;
				}			

				return gui_code;
			}

			private string ScanDollarTokenAndExecute(string gui_code, ref int index, ref CEntityImpl ent)
			{
				if (gui_code.Length <= 0)
					return gui_code;
					
				int sindex = (int) index;
				int lindex = (int) index;
					
				// check for a possiblity of double $$ (for db)
				bool for_disp = true;
				if (gui_code.Length > 0 && gui_code[sindex] == '$')
				{
					if (gui_code.Length > 0 && gui_code[sindex+1] == '$')
					{
						for_disp = false; // for db
						sindex+=2;
					}
					else
						sindex++;
				}

				while(lindex < gui_code.Length &&
					gui_code[lindex] != '\0' &&
					gui_code[lindex] != ' ' && 
					gui_code[lindex] != ')' &&
					gui_code[lindex] != '\"')
					lindex++;
					
				int olength = lindex-sindex;
				string token = gui_code.Substring(sindex, lindex-sindex);
				string result = "";
				if (for_disp)
					result = ExecuteDollarToken_ForDisplay(token, ref ent);
				else
					result = ExecuteDollarToken_ForDB(token, ref ent);
				
				sindex -= 1; // to replace the $ as well.
				if (!for_disp)
					sindex-=1;
					
				gui_code = Utils.ReplaceString(gui_code, sindex, lindex-sindex, result);
				index += result.Length-1; // -1 for removing the dollar

				return gui_code;
			}

			private string ExecuteDollarToken_ForDisplay(string token, ref CEntityImpl ent)
			{
				string ret_gui_val_string = "";
				token = token.ToLower().Trim();
				if (token.Equals("entity_id"))
					ret_gui_val_string = Utils.ObjectToString(ent.ID);
				else if (token.Equals("entity_id_name"))
					ret_gui_val_string = ent.ID_Name;
				else if (token.Equals("entity_name"))
					ret_gui_val_string = ent.Name;
				else if (token.Equals("entity_type_id"))
					ret_gui_val_string = Utils.ObjectToString(ent.Entity_Type.id);
				else if (token.Equals("entity_owner_id"))
					ret_gui_val_string = Utils.ObjectToString(ent.Properties.GetValue("entity_owner_id"));
				else
					ret_gui_val_string = Utils.ObjectToString(ent.Properties.GetValue(token));

				return ret_gui_val_string;
			}

			private string ExecuteDollarToken_ForDB(string token, ref CEntityImpl ent)
			{
				string ret_gui_val_string = "";
				token = token.ToLower().Trim();
				if (token.Equals("entity_id"))
					ret_gui_val_string = Utils.GetDBString(Utils.ObjectToString(ent.ID), "long");
				else if (token.Equals("entity_id_name"))
					ret_gui_val_string = Utils.GetDBString(ent.ID_Name, "string");
				else if (token.Equals("entity_name"))
					ret_gui_val_string = Utils.GetDBString(ent.Name, "string");
				else if (token.Equals("entity_type_id"))
					ret_gui_val_string = Utils.GetDBString(Utils.ObjectToString(ent.Entity_Type.id), "long");
				else if (token.Equals("entity_owner_id"))
					ret_gui_val_string = Utils.GetDBString(Utils.ObjectToString(ent.Properties.GetValue("entity_owner_id")), "long");
				else
					ret_gui_val_string = Utils.GetDBString(Utils.ObjectToString(ent.Properties.GetValue(token)), ent.Properties.GetPropertyType(token));

				return ret_gui_val_string;
			}

			private string ScanSpecialCommandAndExecute(string gui_code, ref int cmd_sindex, ref CEntityImpl ent)
			{// all specific @commands have the form @cmd_name(param1, param2)
				// scan till ( is found
				int ocmd_sindex = cmd_sindex;

				int param_begin_pos = gui_code.IndexOf("(", cmd_sindex);
				if (param_begin_pos < 0)
					return gui_code; // ERROR
					
				int end_param_pos = gui_code.IndexOf(")", param_begin_pos); // this could be nested ()'s
				if (end_param_pos < 0)
					return gui_code;

				// extract the command
				string cmd = gui_code.Substring(cmd_sindex+1,param_begin_pos-cmd_sindex-1);

				CDataBase db = null;
				if (gui_code[cmd_sindex] == '#')
					db = new CDataBase(GRAVE.Server.GlobalsCon.GRAVE_BASE_LOCATION_CONNECTION_STRING);
 				else if (gui_code[cmd_sindex] == '%')
					db = new CDataBase(GRAVE.Server.GlobalsCon.LORE_ENTITIES_DB_CONNECTION_STRING);

				param_begin_pos++; // for the (

				bool nested_braces = false;
				int intrm_braces_pos = gui_code.IndexOf("(", param_begin_pos);
				if (intrm_braces_pos != -1 && intrm_braces_pos < end_param_pos)
					nested_braces = true;

				// create a list of params, it should take care of params with or without quote and also not add nested params
				ArrayList params_list = new ArrayList(); // either a continous string or qouted.
				string param = "" ;
				int curr_param_pos = param_begin_pos;

				bool quoted = false;
				int braces_cnt = 1;
				while (curr_param_pos < end_param_pos+1 || curr_param_pos < gui_code.Length-1)
				{
					char pchar = gui_code[curr_param_pos-1]; 
					char cchar = gui_code[curr_param_pos]; 
					char nchar = gui_code[curr_param_pos+1];

					// check if nested further
					if (nested_braces)
					{
						intrm_braces_pos = gui_code.IndexOf("(", curr_param_pos+1);
						if (intrm_braces_pos != -1 && intrm_braces_pos < end_param_pos)
						{
							if (gui_code[intrm_braces_pos-1] == '@')
							{
								intrm_braces_pos--;
								gui_code = _ParseAndProcessCode(gui_code, ref intrm_braces_pos, ref ent);
								curr_param_pos = intrm_braces_pos+1;
								
								if (curr_param_pos >= 0 && curr_param_pos < gui_code.Length)
									end_param_pos = gui_code.IndexOf(")", curr_param_pos) - 1; 
								pchar = gui_code[curr_param_pos-1]; 
								cchar = gui_code[curr_param_pos]; 
								nchar = gui_code[curr_param_pos+1];
							}
							else
							{
								braces_cnt++;
								end_param_pos = gui_code.IndexOf(")", curr_param_pos+1);
								if (end_param_pos == -1)
									return gui_code;
							}
						}
					}

					// if this is the begin of a param and is quoted.
					if (param == "" && cchar == '\"')
						quoted = true;

					// for all non quoted params
					if (!quoted)		
					{
						if (cchar == ')') // check if end of params is reached.
						{
							braces_cnt--;
							if (braces_cnt == 0)
							{
								params_list.Add(param);
								param = "";
								break;
							}
							else
								param+= cchar;
						}
						else if (cchar == ',') 
						{
							if (braces_cnt == 1)
							{
								params_list.Add(param);
								param = "";
							}
							else
								param+= cchar;
						}
						else
							param+= cchar;
					}
					else 
					{// for all quoted params
						if (cchar == ')') // check if end of params is reached
						{
							braces_cnt--;
							if (braces_cnt == 0)
								break;
							else
								param+= cchar;
						}
						else if (cchar == '\"' && nchar == '\"')
						{
							if (braces_cnt == 1)
							{
								params_list.Add(param);
								param = "";
							}
						}
						else if (cchar == '\"')
						{// this is where the param gets added when the last " is reached.
							if (param != "" && braces_cnt == 1)
							{
								params_list.Add(param);
								param = "";
							}
							else if (param == "")
							{
							}
							else
								param+= cchar;
						}
						else if ((cchar == ',' || cchar == ' ') && 
							param == "") // ignore commas, spaces between params
						{
						}
						else
							param+= cchar;
					}

					curr_param_pos++;
				}

				// now we have the command and the params to execute
				string ret_val = ExecuteCommandAndParams(cmd, params_list, db);

				// replace
				int olength = end_param_pos-cmd_sindex+1;
				gui_code = Utils.ReplaceString(gui_code, cmd_sindex, olength, ret_val);
					
				cmd_sindex += ret_val.Length-1; // for removing the (%) and advancing to next char

				return gui_code;
			}

			private string ExecuteCommandAndParams(string cmd_name, ArrayList params_list, CDataBase db)
			{
				cmd_name = cmd_name.ToLower().Trim();
				if (cmd_name.Equals("entity_type_name"))
				{
					CEntityImpl this_only = ent_ref;
					int index = 0;
					string ret_value = "";
					if(IsSubCommand((string) params_list[0]))
					{
						int sindex = 0;
						CEntityImpl this_only1 = ent_ref;
						code_tag_openned++;
						ret_value = ScanCommandParamsAndExecute((string) params_list[0], ref sindex, ref this_only1);
						code_tag_openned--;
					}
					else
						ret_value = ScanDollarTokenAndExecute((string) params_list[0], ref index, ref this_only);
						
					if (!ret_value.Equals(""))
					{
						CEntityTypeDef t = CGraveEngine.TheEngine.TheLoader.GetEntityTypeDef(System.Convert.ToInt32(ret_value));
						return t.name;
					}
					return "";
				}
				else if (cmd_name.Equals("select"))
				{// expects 2 params a) list of properties to select b) conditions (can be recursive)
					// process params
					string ret_value = "";
						
					// examine the where clause
					string sub_gui_code = Utils.ObjectToString(params_list[2]);
					if(IsSubCommand(sub_gui_code))
					{
						int sindex = 0;
						CEntityImpl this_only = ent_ref;
						code_tag_openned++;
						sub_gui_code = ScanCommandParamsAndExecute(sub_gui_code, ref sindex, ref this_only);
						code_tag_openned--;
					}

					// create the sql string
					params_list[2] = sub_gui_code;
					string qry = "select " + params_list[0] + " from " + params_list[1] + " where " + params_list[2];

					DataTable dt = db.GetDataTable(qry);
					if (dt != null)
					{
						foreach(DataRow r in dt.Rows)
						{
							foreach (object c in r.ItemArray)
								ret_value += Utils.ObjectToString(c) + ","; 

							ret_value = ret_value.Substring(0, ret_value.Length-1);
							ret_value += "\n";
						}

						if (ret_value.Length > 0)
							ret_value = ret_value.Substring(0, ret_value.Length-1);
							
						return ret_value;
					}

					return "";
				}
				else if (cmd_name.Equals("combo_options"))
				{// expects 2 params a) list of properties to select b) conditions (can be recursive)
					// process params
					string ret_value = "";
						
					// examine the where clause
					string sub_gui_code = Utils.ObjectToString(params_list[2]);
					if (IsSubCommand(sub_gui_code))
					{
						int sindex = 0;
						CEntityImpl this_only = ent_ref;
						code_tag_openned++;
						sub_gui_code = ScanCommandParamsAndExecute(sub_gui_code, ref sindex, ref this_only);
						code_tag_openned--;
					}

					// examine the value
					string val = "";
					if (params_list.Count == 4)
					{
						val = Utils.ObjectToString(params_list[3]);
						if(IsSubCommand(val))
						{
							int sindex = 0;
							CEntityImpl this_only = ent_ref;
							code_tag_openned++;
							val = ScanCommandParamsAndExecute(val, ref sindex, ref this_only);
							code_tag_openned--;
						}
					}

					// create the sql string
					params_list[2] = sub_gui_code;
					if (sub_gui_code != "")
						params_list[2] = " where " + params_list[2];

					string qry = "select " + params_list[0] + " from " + params_list[1] + params_list[2];

					DataTable dt = db.GetDataTable(qry);
					if (dt != null)
					{
						foreach(DataRow r in dt.Rows)
						{
							string opt_val = Utils.ObjectToString(r.ItemArray[0]);
							string opt_text = Utils.ObjectToString(r.ItemArray[1]);
							if (val != "" && opt_val == val)
								ret_value += "<option value='" + opt_val + "' selected>" + opt_text + "</option>";
							else
								ret_value += "<option value='" + opt_val + "'>" + opt_text + "</option>";
						}
							
						return ret_value;
					}

					return "";
				}
				else if (cmd_name.Equals("pretty_print_html"))
				{
					string val = Utils.ObjectToString(params_list[0]); 
					if(IsSubCommand(val))
					{
						int sindex = 0;
						CEntityImpl this_only = ent_ref;
						code_tag_openned++;
						val = ScanCommandParamsAndExecute(val, ref sindex, ref this_only);
						code_tag_openned--;
					}

					val = GRAVE.Utils.IndentHtmlCode(Utils.ObjectToString(val));
					val = GRAVE.Utils.MakeHtmlForBrowser(val);
					return val;
				}
				else if (cmd_name.Equals("make_view_html"))
				{
					string val = Utils.ObjectToString(params_list[0]); 
					if(IsSubCommand(val))
					{
						int sindex = 0;
						CEntityImpl this_only = ent_ref;
						code_tag_openned++;
						val = ScanCommandParamsAndExecute(val, ref sindex, ref this_only);
						code_tag_openned--;
					}

					val = GRAVE.Utils.MakeOutViewHtml(val);
					return val;
				}

				return "";
			}

			private bool IsSubCommand(string gui_string)
			{
				if (gui_string == "")
					return false;

				if (gui_string.IndexOf("@(") >= 0 ||
					gui_string.IndexOf("$") >= 0 ||
					gui_string.IndexOf('%') >= 0 ||
					gui_string.IndexOf("#") >= 0)
					return true;

				return false;
			}
		}
	}
}
