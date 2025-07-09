acs <- list(
	 title = "American Community Survey",
	 location = "https://census.gov/", # Update with a more precise link
	 years = c(),
	 variables = c()
)

cps <- list(
	title = "Current Population Survey",
	location = "https://census.gov/", # Update with a more precise link
	years = c(),
	variables = c()
)

ipeds <- list(
	title = "Integrated Postsecondary Education Data System (IPEDS) Institution Lookup",
	location = "https://surveys.nces.ed.gov/ipeds/public/survey-materials/index",
	years = c( 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024 ), # They have data every year since 1994
	variables = c()
)

ncses <- list(
	title = "National Center for Science and Engineering Statistics",
	location = "https://ncses.nsf.gov/",
	years = c(2021, 2023),
	variables = c("Survey of Earned Doctorates",
		     "Survey of Graduate Students and Postdoctorates in Science and Engineering",
		     "Survey of Doctorate Recipients",
		     "Higher Education Research and Development Survey",
		     "National Survey of College Graduates")
)

herd <- list(
	title = "Higher Education Research and Development Survey",
	location = "https://ncses.nsf.gov/surveys/higher-education-research-development/2023", # There are probably more years than 2023
	years = c(2023),
	variables = c("Higher education R&D expenditures, ranked by FY 2023 R&D expenditures: FYs 2010–23",
		      "Total and federally financed higher education R&D expenditures in mathematics and statistics, ranked by FY 2023 total: FYs 2020–23",
		      "Higher education R&D expenditures, by R&D field: FYs 2010–23",
		      "Higher education R&D expenditures, by source of funds and R&D field: FY 2023",
		      "Higher education R&D expenditures at private institutions, ranked by all R&D expenditures, by source of funds: FY 2023",
		      "Higher education R&D expenditures at public institutions, ranked by all R&D expenditures, by source of funds: FY 2023",
		      "Higher education R&D expenditures at high-Hispanic-enrollment institutions, ranked by all R&D expenditures, by R&D field: FY 2023",
		      "Higher education R&D expenditures at historically black colleges and universities, ranked by all R&D expenditures, by source of funds: FY 2023",
		      "Higher education R&D expenditures at high-Hispanic-enrollment institutions, ranked by all R&D expenditures, by source of funds: FY 2023 ",
		      "Higher education R&D expenditures at historically black colleges and universities, ranked by all R&D expenditures, by R&D field: FY 2023",
		      "Higher education R&D expenditures, by source of funds and R&D field: FY 2023",
		      "Higher education R&D expenditures, by R&D field: FYs 2010–23")
		      
		      
)

gss <- list(
	title = "Survey of Graduate Students and Postdoctorates in Science and Engineering",
	location = "https://ncses.nsf.gov/surveys/graduate-students-postdoctorates-s-e/2023", # Same as the previous comment
	years = c(2023),
	variables = c("Citizenship, ethnicity, and race of graduate students, by detailed field: 2023",
		     "Master's and doctoral students within science, engineering, and health fields, by enrollment intensity: 2023",
		     "Demographic characteristics of graduate students, postdoctoral appointees, and doctorate-holding nonfaculty researchers in science, engineering, and health: 2023",
		     "Graduate students in science, engineering, and health broad fields, by degree program, citizenship, ethnicity, and race: 2023")
)

nscg <- list(
	title = "National Survey of College Graduates",
	location = "https://ncses.nsf.gov/pubs/nsf23306/",
	years = c(2021),
	variables = c("College graduates, by level of highest degree, minor field of highest degree, and labor force status: 2021",
		     "Employed scientists and engineers, by sex, major field of highest degree, ethnicity, race, disability status, and type of disability: 2021",
		     "Employed college graduates, by minor occupation and major field of highest degree: 2021",
		     "Employed college graduates, by level of highest degree, minor occupation, and primary work activity: 2021",
		     "Median annual salaries of full-time employed college graduates, by major occupation, age, level of highest degree, and sex: 2021",
		     "Employment counts and median annual salaries of full-time employed scientists and engineers, by major field of highest degree, employment sector, and primary work activity: 2021",
		     "College graduates, by broad field of highest degree, father's education, mother's education, level of highest degree, and median amount borrowed to finance undergraduate degree: 2021")

)

sdr <- list(
	title =
	location = 
	years = c()
	variables = c()

bls <- list(
	title = "Bureau of Labor Statistics",
	location = "https://www.bls.gov/",
	years = c(),
	variables = c( )
)

ooh <- list(
	title = "Occupational Outlook Handbook",
	location = "https://www.bls.gov/ooh/",
	years = c(),
	variables = c()
)

oews <- list(
	title = "Occupational Employment and Wage Statistics",
	location = "https://www.bls.gov/oes/tables.htm",
	years = c(),
	variables = c()
)

ams <- list(
	title = "American Mathematical Society",
	location = "https://ams.org/",
	years = c(),
	variables = c()
)

maa <- list(
	title = "Mathematical Association of America",
	location = "https://maa.org/",
	years = c(),
	variables = c()
)

siam <- list(
	title = "Society for Industrial and Applied Mathematics",
	location = "https://siam.org/",
	years = c(),
	variables = c()
)

awm <- list(
	title = "Association for Women in Mathematics",
	location = "https://awm-math.org/",
	years = c(),
	variables = c()
)

cbms <- list(
	title = "Conference Board of the Mathematical Sciences 2021 Survey",
	location = "www.ams.org/learning-careers/data/cbms-survey/",
	years = c( 2021 ),
	variables = c(
		"Bachelor’s degrees in mathematics, mathematics education, statistics, and computer science in mathematics departments awarded between July 1, 2020 and June 30, 2021, by gender of degree recipient and type of department.",
		"Bachelor’s degrees in statistics departments awarded between July 1, 2020 and June 30, 2021, by gender of degree recipient and type of department.",
		"Enrollment (in thousands) in undergraduate mathematics, statistics, and computer science courses (including distance learning enrollments) in mathematics and statistics departments by level of course and type of department in fall 2021. Numbers in parentheses are (2010, 2015) enrollments.",
		"Number of sections (not including distance learning) of undergraduate mathematics, statistics, and computer science courses in mathematics and statistics departments by level of course and type of department in fall 2021 with fall 2015 figures in parentheses.",
		"Enrollments in distance/remote learning courses (meaning courses offered for credit in which half or more of the instruction occurs with the instructor and the students separated by time and/or place [e.g., courses in which half or more of the course is taught online either synchronously or asynchronously, by computer software, or by other technologies], and other sections for various freshman and sophomore courses, by type of department, in fall 2021. Includes only distance/remote courses offered in normal practice, not courses that became distance/remote due to COVID-19 pandemic. (Fall 2015 data in parentheses.)",
		"Number of sections (excluding distance learning) of calculus-level courses in mathematics departments taught by various types of instructor, by type of department, in fall 2021 with fall 2015 figures in parentheses.",
		"Number of sections (excluding distance learning) of introductory statistics courses taught in mathematics departments and statistics departments by type of instructor and type of department in fall 2021 with fall 2015 figures in parentheses.",
		"Number of sections of advanced mathematics (including operations research) and statistics courses in mathematics departments and of advanced statistics courses in statistics departments taught by tenured/tenure-eligible (TTE) faculty and total number of advanced-level sections by type of department in fall 2021 with fall 2015 data in parentheses.",
		"Number of sections (excluding distance learning) of lower-level computer science courses taught in mathematics departments by type of instructor and type of department in fall 2021 with fall 2015 figures in parentheses.",
		"Number of sections (excluding distance learning) of middle-level computer science courses taught in mathematics departments by type of instructor and type of department in fall 2021 with fall 2015 figures in parentheses.",
		"Average section size (excluding distance learning) for undergraduate mathematics, statistics, and computer science courses in math- ematics and statistics departments by level of course and type of department in fall 2021 with fall 2015 data, when available, in parentheses. Also, all departments’ average section sizes from previous CBMS surveys.",
		"Average recitation size in Mainstream Calculus I and II and other Calculus I courses and in introductory statistics courses that are taught using lecture/recitation method, by type of department in fall 2021, with fall 2015 data in parentheses. Distance learning sections are not included. (A calculus course is “Mainstream” if it leads to the usual upper-division mathematical sciences courses.)",
		"Number of faculty, and of female faculty (F), in various types of mathematics departments and PhD statistics departments by highest degree and type of department in fall 2021. (Fall 2015 figures are in parentheses, and postdocs are included in other full-time (OFT) faculty totals.)",
		"Number of faculty, and of female faculty (F), in mathematics departments combined and of doctoral-level statistics departments in fall 2021. (Fall 2015 figures are in parentheses.)",
		"Number of tenured, tenure-eligible, postdoctoral, and other full-time (OFT) faculty in mathematics departments at four-year colleges and universities by gender and type of department in fall 2021. (Note: Postdoctoral faculty are included in other full-time totals.)",
		"Number of tenured, tenure-eligible, other full-time, and postdoctoral faculty in doctoral-level statistics departments by gender in fall 2021 and 2015. (Postdoctoral faculty are included in other full-time faculty totals.)",
		"Percentage of tenured and tenure-eligible mathematics department faculty and statistics faculty at four-year colleges and universities belonging to various age groups by type of department and gender in fall 2021.",
		"Percentages of full-time faculty belonging to various ethnic groups by gender and type of department in fall 2021. Except for round-off, the percentages within each departmental type sum to 100%.",
		"Percentages of part-time faculty belonging to various ethnic groups by gender and type of department in fall 2021. Except for round-off, the percentages within each departmental type sum to 100%.",
		"Percentage of sections (excluding distance learning sections) in Mainstream Calculus I and Mainstream Calculus II taught by various types of instructors in four-year mathematics departments in fall 2021, by size of sections and type of department. Also average section sizes and enrollments (not including distance learning enrollments).",
		"Percentage of sections (excluding distance learning sections) in Non-Mainstream Calculus I and in Non-Mainstream Calculus II, III, etc. taught by various types of instructors in mathematics departments in fall 2021 by size of sections and type of department. Also average section size and enrollments (not including distance learning enrollments).",
		"Percentage of sections (excluding distance learning sections) in Introductory Statistics courses (for non-majors) taught by various types of instructors in mathematics departments in fall 2021, by size of sections and type of department. Also average section size and enrollments (not including distance learning enrollments).",
		"Percentage of sections (excluding distance learning sections) in Introductory Statistics courses (for non-majors) taught by various types of instructors in statistics departments in fall 2021, by size of sections and type of department. Also average section size and total (non-distance learning) enrollments.",
		"Percentage of mathematics departments using various practices in the teaching of Introductory Statistics (no calculus prerequisite) in fall 2021 by type of department.",
		"Instructional strategies used in Introductory Statistics courses.",
		"Extent of success in the use of technology in Introductory Statistics.",
		"Of departments that offered Introductory Statistics (no calculus prerequisite) in fall 2021 and where a similar course is offered outside the mathematical sciences departments, the average estimated fall 2021 enrollment of all similar courses and an estimate of the total national enrollment.",
		"Total institutional enrollment (in thousands) and percentage of part-time enrollments in two year colleges in fall for 1980 through 2015 and projected enrollments for fall 2021. Enrollments include distance learning but not dual enrollments",
		"Enrollments in mathematics and statistics (no computer science) courses in mathematics programs at two-year colleges in fall 1985, 1990, 1995, 2000, 2005, 2010, 2015, and 2021.",
		"Enrollment in thousands in mathematics and statistics courses (not including dual enrollments; including distance enrollments) in mathematics departments at two-year colleges in fall 2005, 2010, 2015, and 2021.",
		"Enrollment in 1000s (not including dual enrollments; including distance enrollments) and percentages of total enrollment in mathematics and statistics courses by type of course in mathematics departments at two-year colleges in fall 2000, 2005, 2010, 2015, and 2021.",
		"Percentage of two-year college mathematics departments teaching mathematics courses in fall 2015 and fall 2021.",
		"Percentage of two-year college mathematics departments teaching selected mathematics courses in the fall terms of 2005, 2010, 2015, and 2021.",
		"Average on-campus section size by type of course in mathematics departments at two-year colleges in fall 2010, 2015, and 2021. Also percentage of sections with enrollment above 30 in fall 2015 and 2021.",
		"Average distance learning section size by type of course in mathematics departments at public two-year colleges in fall 2021. Also percentage of sections with enrollment above 30 in fall 2021.",
		"Average on-campus and distance learning section size for public two-year college mathematics department courses in fall 2021.",
		"Number of sections and number and percentage of sections taught by part-time faculty in mathematics departments at public two-year colleges by type of course in fall 2015 and 2021 (excluding distance learning and dual-enrollment sections).",
		"Percentage of mathematics departments at public two-year colleges which implemented a Pathways course sequence in 2015 and 2021, an Intermediate Algebra prerequisite in 2021, and the types of courses implemented.",
		"Enrollments in distance/remote learning (in 1000s) and percentage of distance/remote learning enrollments (distance learning courses are courses in which half or more of the instruction occurs with the instructor and the students separated by time and/or place facilitated by technology) among all enrollments (excluding dual enrollments) in mathematics departments at two-year colleges in fall 2010, 2015, and 2021.",
		"Percentage of mathematics departments reporting use of distance learning in mathematics departments at two-year colleges in 2013–2021.",
		"Percentage of departments with distance learning that described various factors as significant challenges or somewhat of a challenge in fall 2021.",
		"Percentage of two-year colleges offering various opportunities and services to mathematics students in fall 2010, 2015, and 2021.",
		"Number of full-time permanent faculty, full-time temporary faculty, other full-time faculty, and part-time faculty paid by two-year colleges (TYC) and by a third party (e.g., dual-enrollment instructors) in mathematics departments at two-year colleges in fall 2005, 2010, 2015, and 2021.",
		"Teaching assignment for full-time permanent faculty, and teaching and other duties of part-time faculty, in mathematics departments at two-year colleges in fall 2021 (2015 data in parentheses).",
		"Number of full-time permanent faculty in 2020–2021 who were no longer part of the faculty in 2025–2016 and 2021–2022.",
		"Percentage of full-time permanent faculty in mathematics departments at two-year colleges by highest degree in fall 2000, 2005, 2010, 2015, and 2021.",
		"Percentage of full-time permanent faculty in mathematics programs at public two-year colleges by field and highest degree in fall 2021.",
		"Percentage of part-time faculty in mathematics departments at two-year colleges (including those paid by a third party, as in dual-enrollment courses) by highest degree in fall 2000, 2005, 2010, 2015, and 2021.",
		"Percentage of part-time faculty in mathematics departments at two-year colleges (including those paid by a third party, as in dual-enrollment courses) by field and highest degree in fall 2021, with 2015 data in parentheses.",
		"Number and percentage of total full-time permanent faculty in mathematics departments at two-year colleges by gender in fall 2005, 2010, 2015, and 2021.",
		"Percentage of full-time permanent faculty and part-time faculty in mathematics departments at public two-year colleges by gender in fall 2021. Also master’s degrees in mathematics and statistics granted in the U.S. to citizens and resident aliens, by gender, in 2019–20. Part-time faculty paid by a third party are not included.",
		"Percentage and number of ethnic minority full-time permanent faculty in mathematics departments at two-year colleges in fall 2005, 2010, 2015, and 2021.",
		"Percentage of full-time permanent faculty in mathematics departments at two-year colleges by ethnicity in fall 2005, 2010, 2015, and 2021",
		"Number and percentage of full-time permanent faculty in mathematics departments at two year colleges by ethnic group, and percentage of women within each ethnic group in fall 2021.",
		"Percentage of full-time permanent faculty and of full-time permanent faculty under age 40 in mathematics departments at public two-year colleges by ethnic group in fall 2021. Also U.S. master’s degrees in mathematics and statistics granted in the U.S. to citizens and resident aliens by ethnic group in 2020–21.",
		"Percentage of ethnic minority part-time faculty in mathematics departments at public two-year colleges in fall 2010, 2015, and 2021.",
		"Number and percentage of part-time faculty in mathematics departments at public two-year colleges by ethnic group, and percentage of women within each ethnic group in fall 2021.",
		"Percentage and number of full-time permanent faculty in mathematics departments at two-year colleges by age in fall 2005, 2010, 2015, and 2021.",
		"Percentage of full-time permanent faculty in mathematics departments at public two-year colleges by age and by gender, and percentage of women by age in fall 2021.",
		"Percentage of newly appointed full-time permanent faculty in mathematics departments at two-year colleges coming from various sources in fall 2015 and 2021.",
		"Percentage of full-time permanent faculty newly appointed in mathematics departments at two-year colleges by highest degree in fall 2015 and 2021.",
		"Percentage of full-time permanent faculty newly appointed in mathematics departments at two year colleges by ethnic group in fall 2015 and 2021. Also percentage of women within each ethnic group in fall 2021.",
		"Percentage of two-year colleges that require periodic teaching evaluations for all full-time or all part-time faculty in fall 2015 and 2021.",
		"Percentage of mathematics departments at public two-year colleges using various methods of evaluating teaching of full- and part-time faculty in fall 2021.",
		"Percentage of two-year colleges that require some form of continuing education or professional development for full-time permanent faculty, and percentage of faculty using various methods to fulfill those requirements, in mathematics departments at two-year colleges in fall 2015 and 2021.",
		"Percentage of program heads classifying various problems as “major” in mathematics departments at two-year colleges in fall 2005, 2010, 2015, and 2021.",
		"Percentage of program heads of mathematics departments at public two-year colleges classifying various problems by severity in fall 2021." )
)

ipums <- list(
	title = "IPUMS",
	location = "https://ipums.org/",
	years = c(),
	variables = c()
)

data_gov <- list(
	title = "Data.gov",
	location = "https://data.gov/",
	years = list(),
	variables = list()
)

harvard_dataverse <- list(
	title = "Harvard Dataverse",
	location = "https://dataverse.harvard.edu/",
	years = c(),
	variables = c()
)

pewresearch <- list(
	title = "Pewresearch",
	location = "https://pewresearch.org/",
	years = c(),
	variables = c()
)

urban <- list(
	title = "Urban Institute",
	location = "https://urban.org/",
	years = c(),
	variables = c()
)

variables <- data.frame(t(list(acs, cps, ipeds, ncses, sed, gss, bls, ooh, oews, ams, maa, siam, awm, cbms, ipums, data_gov, harvard_dataverse, pewresearch, urban)))

variables
