-------------------------------------------------------------- Demographics Insights ---------------------------------------------------------------------------
/* a. Who prefers energy drink more? (male/female/non-binary?)
	  
	  Findings -  Taking in account that the consume frequency should be,
	    Daily                                
		2-3 times a week
		Once a week
		2-3 times a month    --- Male	4852 prefers energy drink more ,followed by Female 2793 and then Non-binary	414*/

select rdnt.Gender,COUNT(resp.response_id) as total_count_prefer
from marketing.dbo.fact_survey_responses resp
join marketing.dbo.dim_repondents rdnt on  resp.Respondent_ID= rdnt.Respondent_ID
where Consume_frequency <> 'Rarely'
group by Gender 
order by total_count_prefer desc

/* b. Which age group prefers energy drinks more?

	Findings - 19-30	4432
			   31-45	1916
			   15-18	1211
			   46-65	349
               65+	    151   Age Group 19-30 Prefers the energy drink more than other age groups*/

select rdnt.Age,COUNT(resp.response_id) as total_count_prefer
from marketing.dbo.fact_survey_responses resp
join marketing.dbo.dim_repondents rdnt on  resp.Respondent_ID= rdnt.Respondent_ID
where Consume_frequency <> 'Rarely'
group by Age
order by total_count_prefer desc

/* c. Which type of marketing reaches the most Youth (15-30)?

	Findings -  Online ads	        3373	
				TV commercials	    1785
				Outdoor billboards	702
				Other				702
				Print media			446     Online marketing reaches the most youth in (15-30) Age Group */

select resp.Marketing_channels,COUNT(resp.response_id) as total_count_prefer
from marketing.dbo.fact_survey_responses resp
join marketing.dbo.dim_repondents rdnt on  resp.Respondent_ID= rdnt.Respondent_ID
where Age in ('15-18','19-30')
group by Marketing_channels
order by total_count_prefer desc



-------------------------------------------------------------- Consumer Preferences ---------------------------------------------------------------------------
/* a. What are the preferred ingredients of energy drinks among respondents?

	Findings-	Caffeine	3896
				Vitamins	2534
				Sugar		2017
				Guarana		1553			caffine is the most preferred ingredient */

select resp.Ingredients_expected,COUNT(resp.response_id) as total_count_prefer
from marketing.dbo.fact_survey_responses resp
join marketing.dbo.dim_repondents rdnt on  resp.Respondent_ID= rdnt.Respondent_ID
group by Ingredients_expected
order by total_count_prefer desc


/* b. What packaging preferences do respondents have for energy drinks?

	Findings Compact and portable cans	2205
	Innovative bottle design			1656
	Compact and portable cans			938                  These are the top 3 packaging preference. */

select resp.Packaging_preference,COUNT(resp.response_id) as total_count_prefer
from marketing.dbo.fact_survey_responses resp
join marketing.dbo.dim_repondents rdnt on  resp.Respondent_ID= rdnt.Respondent_ID
group by age,Packaging_preference
order by total_count_prefer desc


-------------------------------------------------------------- Competition Analysis ---------------------------------------------------------------------------
/* a. Who are the current market leaders?

	Findings-   Cola-Coka	2538
				Bepsi		2112
				Gangster	1854				These are the top 3 brands */


select resp.Current_brands,COUNT(resp.response_id) as total_count_prefer
from marketing.dbo.fact_survey_responses resp
join marketing.dbo.dim_repondents rdnt on  resp.Respondent_ID= rdnt.Respondent_ID
group by Current_brands
order by total_count_prefer desc


/* b. What are the primary reasons consumers prefer those brands over ours?

	Findings -  Brand reputation		2652
				Taste/flavor preference	2011
				Availability			1910				These are the top 3 reasons for the comsumer for brand preference */


select resp.Reasons_for_choosing_brands,COUNT(resp.response_id) as total_count_prefer
from marketing.dbo.fact_survey_responses resp
join marketing.dbo.dim_repondents rdnt on  resp.Respondent_ID= rdnt.Respondent_ID
group by Reasons_for_choosing_brands
order by total_count_prefer desc


-------------------------------------------- Marketing Channels and Brand Awarness ---------------------------------------------------------------------------
/* a. Which marketing channel can be used to reach more customers?
	Findings-   Online ads			4020
				TV commercials		2688
				Outdoor billboards	1226               These are the top 3 marketing channels for reaching customers */


select resp.Marketing_channels,COUNT(resp.response_id) as total_count_prefer
from marketing.dbo.fact_survey_responses resp
join marketing.dbo.dim_repondents rdnt on  resp.Respondent_ID= rdnt.Respondent_ID
group by Marketing_channels
order by total_count_prefer desc


/* b. How effective are different marketing strategies and channels in reaching our customers?*/





--------------------------------------------------------------- Brand Penetration ---------------------------------------------------------------------------
/* a. What do people think about our brand? (overall rating)
	Finding - 
	Total Users who consumes drink atleast once - 4881	
	Average Ratings of the Users				- 3.27 */


select COUNT(response_id) as Total_users_who_consumed_drink_atleast_once , round(AVG(taste_experience),2) as Average_Ratings_Given
from marketing.dbo.fact_survey_responses
where Tried_before = 'yes'


/* b. Which cities do we need to focus more on?
	
	Findings -	Chennai	3.23
				Delhi	3.25
				Jaipur	3.26		 These are the cities with Ratings Lower than the Overall Average Ratings of 3.29 */


select dc.city, round(avg(resp.taste_experience),2) as Average_Ratings_by_city
from marketing.dbo.fact_survey_responses resp
join marketing.dbo.dim_repondents rndt on resp.Respondent_ID=rndt.Respondent_ID
join marketing.dbo.dim_cities dc on rndt.City_ID=dc.City_ID
group by City
having avg(resp.taste_experience) <= 3.27
order by Average_Ratings_by_city


-------------------------------------------------------------------Purchase Behaviour----------------------------------------------------------------------------
/* a. Where do respondents prefer to purchase energy drinks?
	Findings-	Supermarkets				4494
				Online retailers			2550
				Gyms and fitness centers	1464                 Top 3 preferred locations */


select purchase_location, COUNT(response_id) as Total_Count
from marketing.dbo.fact_survey_responses
group by Purchase_location
order by Total_Count desc


/* b. What are the typical consumption situations for energy drinks among respondents?

	Findings -	Sports/exercise			4494
				Studying/working late	3231
				Social outings/parties	1487			These are the top three consumption situations */


select Typical_consumption_situations, COUNT(response_id) as Total_Count
from marketing.dbo.fact_survey_responses
group by Typical_consumption_situations
order by Total_Count desc


/* c. What factors influence respondents' purchase decisions, such as price range and limited edition packaging?	Findings-	50-99	No	1741
				50-99	Yes	1679
				100-150	Yes	1263
				100-150	No	1244       The Pice Range should be between 50 and 150, And limited edition preference is 50/50. */select Price_range,Limited_edition_packaging, COUNT(response_id) as Total_Count
from marketing.dbo.fact_survey_responses
group by Price_range,Limited_edition_packaging
order by Total_Count desc-------------------------------------------------------------------Product Development--------------------------------------------------------------------------/* a. Which area of business should we focus more on our product development? (Branding/taste/availability)

	Findings - Not available locally   we should focus more on the Availability */


select Reasons_preventing_trying, COUNT(response_id) as Total_Count
from marketing.dbo.fact_survey_responses
group by Reasons_preventing_trying
order by Total_Count desc

