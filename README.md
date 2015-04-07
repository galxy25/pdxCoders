# pdxCoders
CS Capstone 2015
Team-D

Raven Allan
Parker Berger
Laura DeWitt
Brandon Isom
Brady Sullivan
Evan Schott
Joseph Stewart
Levi Schoen

##Tools we are using:

Github:

Pivotal Tracker:

Google Calander:

SourceTree or Terminal:

##Source Control Workflow
	master(production)
		staging-beta(testing)
		development(equal to staging-beta, not deployed)
			features/
			bugs/
			hotfixes/
			releases/

	Pull from development(rebase okay)
	Create new branch, i.e.
		features/really_cool_thing_pivotalNumber
		bugs/save_the_day_pivotalNumber

	Code. Then commit
[(Finishes|Fixes|Delivers) #TRACKER_STORY_ID] Brief Description
			-Commit Message comments go here
			-“...“
			-“…"
	Create pull request in github
	Must be code reviewed with at least one other team member before merging.
	Merge your local branch with staging-beta, then merge staging-beta with  development. All merges to production will be done by the team lead.

