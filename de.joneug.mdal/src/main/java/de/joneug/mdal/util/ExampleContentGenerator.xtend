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
					template("Gen. Product Posting Group" ; GenProductPostingGroup)
					field("Duration Days"; Decimal)
					field("Minimum Participants"; Integer)
					field("Maximum Participants"; Integer)
					field("Language Code"; Code[10])
					field("Seminar Price"; Decimal)
				}
			}
			
			document {
				header "Seminar Registration Header" {
					ShortName = "Sem. Reg. Header";
				}
				
				line "Seminar Registration Line" {
					ShortName = "Sem. Reg. Line";
				}
			}
			
			journal "Seminar Journal Line" {
				ShortName = "Sem. Jnl. Line";
				
				fields {
					include("Seminar"."Language Code")
					field("Picture"; Media)
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
					template("Gen. Product Posting Group" ; GenProductPostingGroup)
					field("Duration Days"; Decimal)
					field("Minimum Participants"; Integer)
					field("Maximum Participants"; Integer)
					field("Language Code"; Code[10])
					field("Seminar Price"; Decimal)
				}
			}
			
			document {
				header "Seminar Registration Header" {
					ShortName = "Sem. Reg. Header";
				}
				
				line "Seminar Registration Header" {
					ShortName = "Sem. Reg. Line";
				}
			}
			
			journal "Seminar Journal Line" {
				ShortName = "Sem. Jnl. Line";
				
				fields {
					include("Seminar"."Language Code1")
					field("Picture"; Media)
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
