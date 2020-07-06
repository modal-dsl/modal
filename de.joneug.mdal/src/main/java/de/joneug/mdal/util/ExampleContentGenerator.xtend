package de.joneug.mdal.util

class ExampleContentGenerator {

	static def generateCorrectModel() '''
		solution "Seminar Management" {
			Prefix = "SEM";
			
			master "Seminar" {
				ShortName = "Sem.";
				
				fields { 
					field("Picture"; Media)
					template("Description" ; Description)
					field("Duration Days"; Decimal)
					field("Minimum Participants"; Integer)
					field("Maximum Participants"; Integer)
					field("Language Code"; Code[10])
					field("Seminar Price"; Decimal)
				}
			}
			
			supplemental "Seminar Room" {
		        ShortName = "Sem. Room";
		
		        fields {
		            template("Name"; Name)
		            template("Address"; Address)
		            template("Contact Information"; ContactInfo)
		            template("Salesperson"; Salesperson)
		            field("Resource No."; Code[20])
		            field("Internal/External"; Option[" ", "Internal", "External"])
		            field("Maximum Participants"; Integer)
		            template("Dimensions"; Dimensions)
		        }
		    }
		    
		    supplemental "Instructor" {
		    	ShortName = "Inst.";
		    	
		    	fields {
		    		template("Name"; Name)
		    		template("Contact Information"; ContactInfo)
		    		field("Contact No."; Code[20])
		    		field("Resource No."; Code[20])
		    		template("Salesperson"; Salesperson)
		    		field("Internal/External"; Option[" ", "Internal", "External"])
		    		field("Language Code"; Code[10])
		    		template("Dimensions"; Dimensions)
		    	}
		    }
			
			document "Seminar Registration" {
				ShortName = "Sem. Reg.";
				
				header "Seminar Registration Header" {
					ShortName = "Seminar Reg. Header";
				}
				
				line "Seminar Registration Line" {
					ShortName = "Seminar Reg. Line";
				}
			}
			
			ledgerEntry "Seminar Ledger Entry" {
				ShortName = "Sem. Ledger Entry";
				
				fields {
					field("Picture"; Media)
					include("Language Code"; "Seminar"."Language Code")
					include("Maximum Participants"; "Seminar"."Maximum Participants")
				}
				
				listPage {
					field("Picture")
					field("Maximum Participants")
				}
			}
		}
	'''

	static def generateModelWithErrors() '''
		solution "Seminar Management" {
			Prefix = "SEM";
			
			master "Seminar" {
				ShortName = "Sem.";
				
				fields { 
					field("Picture"; Media)
					field("Duration Days"; Decimal)
					field("Minimum Participants"; Integer)
					field("Maximum Participants"; Integer)
					field("Language Code"; Code[10]) {
						TableRelation = "Language1";
					}
					field("Seminar Price"; Decimal)
					template("Seminar Price" ; Dimensions)
				}
			}
			
			document "Seminar Registration" {
				ShortName = "Sem. Reg.";
				
				header "Seminar Registration Header" {
					ShortName = "Sem. Reg. Header";
				}
				
				line "Seminar Registration Header" {
					ShortName = "Sem. Reg. Line";
				}
			}
			
			ledgerEntry "Seminar Ledger Entry" {
				ShortName = "Sem. Ledger Entry";
				
				fields {
					field("Picture"; Media)
					include("Language Code"; "Seminar"."Language Code1")
					include("Language Code"; "Seminar"."Maximum Participants")
				}
				
				listPage {
					field("Picture")
					field("ABC")
					field("Language Code")
				}
			}
		}
	'''

	static def generateAppJson() '''
		{
			"id": "9b4b40f4-d5cd-44a6-b56f-5b08621190a7",
			"name": "Seminar Management (mdAL)",
			"publisher": "joneug",
			"version": "1.0.0.0",
			"brief": "",
			"description": "",
			"privacyStatement": "",
			"EULA": "",
			"help": "",
			"url": "",
			"logo": "",
			"dependencies": [
				{
					"id": "63ca2fa4-4f03-4f2b-a480-172fef340d3f",
					"publisher": "Microsoft",
					"name": "System Application",
					"version": "16.0.0.0"
				},
				{
					"id": "437dbf0e-84ff-417a-965d-ed2bb9650972",
					"publisher": "Microsoft",
					"name": "Base Application",
					"version": "16.0.0.0"
				}
			],
			"screenshots": [],
			"platform": "16.0.0.0",
			"idRanges": [
				{
					"from": 123456700,
					"to": 123456799
				},
				{
					"from": 123456800,
					"to": 123456899
				}
			],
			"contextSensitiveHelpUrl": "https://ALProject1.com/help/",
			"showMyCode": true,
			"runtime": "5.0"
		}
	'''

}
