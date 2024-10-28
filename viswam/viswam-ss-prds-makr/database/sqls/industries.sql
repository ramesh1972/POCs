-- create mysql table for tree of industries
CREATE TABLE industries (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    parent_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    PRIMARY KEY (id),
    FOREIGN KEY (parent_id) REFERENCES industries(id),
    UNIQUE (name),
    INDEX (id)
);

-- create this stored procedure to insert subindustry in industries table
DELIMITER //

CREATE PROCEDURE `sp_insert_subindustry` (IN `industry_name` VARCHAR(255), IN `subindustry_name` VARCHAR(255), IN `description` TEXT)
BEGIN
    DECLARE industry_id INT;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
    SELECT 
        id INTO industry_id 
    FROM
        industries
    WHERE
        name = industry_name;
    IF industry_id IS NOT NULL THEN
        INSERT INTO industries (name, description, parent_id) VALUES (subindustry_name, description, industry_id);
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END//

DELIMITER ;

-- insert into industries (name, description, parent_id) following values with parent_id as -1
-- Advertising and Marketing
-- Aerospace and Aviation
-- Aerospace and Defense
-- Agriculture
-- Automotive
-- Banking and Financial Services
-- Construction
-- Education
-- Energy
-- Energy and Utilities
-- Entertainment and Media
-- Environmental Services
-- Fashion and Beauty
-- Finance
-- Food and Beverage
-- Healthcare
-- Hospitality and Leisure
-- Information Technology
-- Insurance
-- Mining and Metals
-- Pharmaceuticals
-- Pharmaceuticals and Biotechnology
-- Real Estate
-- Retail
-- Technology
-- Telecommunications
-- Textile
-- Tourism
-- Transportation
-- Travel
-- Utilities
-- Wholesale and Retail Trade
-- Wholesale Trade
-- Supply Chain
-- Logistics
-- Manufacturing
-- Media and Entertainment
-- Medical Devices
-- Metals and Mining
-- Nonprofit
-- Oil and Gas
-- Packaging
-- Paper and Forest Products
-- Personal Care
-- Petrochemicals
-- Plastics
-- Professional Services
-- Publishing
-- Renewable Energy
-- Restaurants
-- Retail and Consumer Products
-- Security
-- Semiconductors
-- Shipping
-- Software
-- Sports
-- Technology Hardware
-- Telecommunications Services
-- Textiles
-- Tobacco
-- Transportation and Logistics
-- Tourism
-- Waste Management
-- Water
-- Wood Products
-- Other
INSERT into industries (name, description, parent_id) values
('Advertising and Marketing', 'Advertising and Marketing', null),
('Aerospace and Aviation', 'Aerospace and Aviation', null),
('Aerospace and Defense', 'Aerospace and Defense', null),
('Agriculture', 'Agriculture', null),
('Automotive', 'Automotive', null),
('Banking and Financial Services', 'Banking and Financial Services', null),
('Construction', 'Construction', null),
('Education', 'Education', null),
('Energy', 'Energy', null),
('Energy and Utilities', 'Energy and Utilities', null),
('Entertainment and Media', 'Entertainment and Media', null),
('Environmental Services', 'Environmental Services', null),
('Fashion and Beauty', 'Fashion and Beauty', null),
('Finance', 'Finance', null),
('Food and Beverage', 'Food and Beverage', null),
('Healthcare', 'Healthcare', null),
('Hospitality and Leisure', 'Hospitality and Leisure', null),
('Information Technology', 'Information Technology', null),
('Insurance', 'Insurance', null),
('Mining and Metals', 'Mining and Metals', null),
('Pharmaceuticals', 'Pharmaceuticals', null),
('Pharmaceuticals and Biotechnology', 'Pharmaceuticals and Biotechnology', null),
('Real Estate', 'Real Estate', null),
('Retail', 'Retail', null),
('Technology', 'Technology', null),
('Telecommunications', 'Telecommunications', null),
('Textile', 'Textile', null),
('Tourism', 'Tourism', null),
('Transportation', 'Transportation', null),
('Travel', 'Travel', null),
('Utilities', 'Utilities', null),
('Wholesale and Retail Trade', 'Wholesale and Retail Trade', null),
('Wholesale Trade', 'Wholesale Trade', null),
('Supply Chain', 'Supply Chain', null),
('Logistics', 'Logistics', null),
('Manufacturing', 'Manufacturing', null),
('Media and Entertainment', 'Media and Entertainment', null),
('Medical Devices', 'Medical Devices', null),
('Metals and Mining', 'Metals and Mining', null),
('Nonprofit', 'Nonprofit', null),
('Oil and Gas', 'Oil and Gas', null),
('Packaging', 'Packaging', null),
('Paper and Forest Products', 'Paper and Forest Products', null),
('Personal Care', 'Personal Care', null),
('Petrochemicals', 'Petrochemicals', null),
('Plastics', 'Plastics', null),
('Professional Services', 'Professional Services', null),
('Publishing', 'Publishing', null),
('Renewable Energy', 'Renewable Energy', null),
('Restaurants', 'Restaurants', null),
('Retail and Consumer Products', 'Retail and Consumer Products', null),
('Security', 'Security', null),
('Semiconductors', 'Semiconductors', null),
('Shipping', 'Shipping', null),
('Software', 'Software', null),
('Sports', 'Sports', null),
('Technology Hardware', 'Technology Hardware', null),
('Telecommunications Services', 'Telecommunications Services', null),
('Textiles', 'Textiles', null),
('Tobacco', 'Tobacco', null),
('Transportation and Logistics', 'Transportation and Logistics', null),
('Tourism', 'Tourism', null),
('Waste Management', 'Waste Management', null),
('Water', 'Water', null),
('Wood Products', 'Wood Products', null),
('Other', 'Other', null);

-- insert these sub-industries using the stop procedure sp_insert_subindustry
-- Advertising and Marketing,	Advertising Agencies,	Creating and implementing ad campaigns
-- Advertising and Marketing,	Affiliate Marketing,	Promoting products through affiliates
-- Advertising and Marketing,	Brand Strategy and Positioning,	Developing brand identity and market positioning
-- Advertising and Marketing,	Branding and Identity,	Creating and managing brand image and identity
-- Advertising and Marketing,	Content Creation,	Producing creative content for marketing
-- Advertising and Marketing,	Content Marketing,	Creating and distributing valuable content
-- Advertising and Marketing,	Digital Advertising Networks,	Online advertising networks and platforms
-- Advertising and Marketing,	Digital Marketing,	Online marketing strategies and campaigns
-- Advertising and Marketing,	Direct Mail Advertising,	Sending promotional materials via mail
-- Advertising and Marketing,	Email Marketing,	Promoting products and services via email
-- Advertising and Marketing,	Email Newsletter Marketing,	Sending promotional emails to subscribers
-- Advertising and Marketing,	Event Marketing,	Promoting products and services at events
-- Advertising and Marketing,	Guerilla Marketing,	Unconventional and creative marketing strategies
-- Advertising and Marketing,	Influencer Marketing,	Promoting products through influential individuals
-- Advertising and Marketing,	Influencer Networks,	Connecting brands with social media influencers
-- Advertising and Marketing,	Market Analysis and Research,	Conducting research to understand markets
-- Advertising and Marketing,	Market Research,	Gathering and analyzing consumer data
-- Advertising and Marketing,	Mobile Advertising,	Advertising on mobile devices
-- Advertising and Marketing,	Native Advertising,	Blending ads with the surrounding content
-- Advertising and Marketing,	Outdoor Advertising,	Billboards, transit ads, and other outdoor media
-- Advertising and Marketing,	Print Advertising,	Traditional print media for advertising
-- Advertising and Marketing,	Public Relations,	Managing communications and reputation
-- Advertising and Marketing,	Search Engine Marketing (SEM),	Paid advertising on search engines
-- Advertising and Marketing,	Search Engine Optimization (SEO),	Improving website visibility in search engines
-- Advertising and Marketing,	Social Media Management,	Managing social media presence and interactions
-- Advertising and Marketing,	Social Media Marketing,	Promoting brands and products on social media
-- Advertising and Marketing,	Video Advertising,	Advertising through online video content
-- Aerospace and Aviation,	Aerospace Engineering,	Designing and developing aerospace technologies
-- Aerospace and Aviation,	Aerospace Materials,	Manufacturing materials used in aerospace
-- Aerospace and Aviation,	Air Cargo Services,	Transporting cargo by air
-- Aerospace and Aviation,	Air Freight Services,	Transporting cargo by air
-- Aerospace and Aviation,	Air Traffic Control,	Managing and directing air traffic
-- Aerospace and Aviation,	Air Traffic Management,	Controlling air traffic for safe operations
-- Aerospace and Aviation,	Aircraft Leasing,	Renting out aircraft to airlines and operators
-- Aerospace and Aviation,	Aircraft Leasing and Financing,	Leasing and financing aircraft
-- Aerospace and Aviation,	Aircraft Maintenance, Repair, and Overhaul,	Servicing and repairing aircraft
-- Aerospace and Aviation,	Aircraft Manufacturing,	Producing various types of aircraft
-- Aerospace and Aviation,	Aircraft Parts Manufacturing,	Producing components for aircraft
-- Aerospace and Aviation,	Airfreight and Cargo,	Transporting goods by air
-- Aerospace and Aviation,	Airline Services,	Operating scheduled air transportation services
-- Aerospace and Aviation,	Airport Operations,	Managing and operating airports
-- Aerospace and Aviation,	Aviation Consulting,	Providing expertise on aviation projects
-- Aerospace and Aviation,	Aviation Maintenance,	Repair and maintenance of aircraft
-- Aerospace and Aviation,	Aviation Training,	Providing training for pilots and aviation staff
-- Aerospace and Aviation,	Avionics Manufacturing,	Designing and manufacturing aviation electronics
-- Aerospace and Aviation,	Commercial Airlines,	Passenger air transportation services
-- Aerospace and Aviation,	Flight Training,	Providing pilot and crew training
-- Aerospace and Aviation,	Private Aviation,	Private jet services and charters
-- Aerospace and Aviation,	Satellite Technology,	Developing and launching satellites
-- Aerospace and Aviation,	Space Tourism,	Commercial space travel and tourism
-- Aerospace and Aviation,	Spacecraft Design and Engineering,	Designing spacecraft and satellite technologies
-- Aerospace and Aviation,	Spacecraft Manufacturing,	Building spacecraft and satellite technologies
-- Aerospace and Defense,	Aerospace Manufacturing,	Producing aircraft, spacecraft, and related parts
-- Aerospace and Defense,	Defense Contractors,	Providing products and services to the military
-- Aerospace and Defense,	Military Technology,	Developing technology for military applications
-- Aerospace and Defense,	Satellite Services,	Communication and observation via satellites
-- Aerospace and Defense,	Space Exploration,	Research and exploration beyond Earth's atmosphere
-- Agriculture,	Agribusiness,	Integrated farming and agricultural industries
-- Agriculture,	Agricultural Equipment Rental,	Renting farm machinery and equipment
-- Agriculture,	Agricultural Machinery Leasing,	Renting agricultural equipment and machinery
-- Agriculture,	Agricultural Machinery Manufacturing,	Producing equipment for agriculture
-- Agriculture,	Agricultural Research,	Advancing agricultural practices through research
-- Agriculture,	Agrochemicals,	Chemical products used in agriculture
-- Agriculture,	Agroforestry,	Integrating trees and agriculture practices
-- Agriculture,	Aquaculture,	Cultivating aquatic organisms for consumption
-- Agriculture,	Aquaponics,	Combining aquaculture and hydroponics for farming
-- Agriculture,	Aquatic Farming,	Cultivating aquatic plants and animals
-- Agriculture,	Crop Production,	Growing and harvesting agricultural crops
-- Agriculture,	Grain and Oilseed Milling,	Processing grains and oilseeds into products
-- Agriculture,	Greenhouse Farming,	Cultivating crops in controlled environments
-- Agriculture,	Horticulture,	Cultivating and managing gardens and landscapes
-- Agriculture,	Irrigation Systems,	Supplying water to crops and farmlands
-- Agriculture,	Livestock Farming,	Raising animals for food and other products
-- Agriculture,	Livestock Feed Additives,	Supplements for animal feed
-- Agriculture,	Livestock Feed Manufacturing,	Producing feed for livestock and animals
-- Agriculture,	Precision Agriculture,	Using technology for optimized farming
-- Agriculture,	Seed Production,	Producing and distributing agricultural seeds
-- Automotive,	Auto Body Repair,	Restoring and repairing vehicle bodies
-- Automotive,	Automobile Manufacturing,	Producing cars, trucks, and motorcycles
-- Automotive,	Automotive Aftermarket,	Providing vehicle parts and accessories
-- Automotive,	Automotive Dealerships,	Retailing new and used vehicles
-- Automotive,	Automotive Design and Engineering,	Designing vehicles and their components
-- Automotive,	Automotive Design and Styling,	Styling and shaping the appearance of vehicles
-- Automotive,	Automotive Electronics,	Manufacturing electronic components for vehicles
-- Automotive,	Automotive Electronics Repair,	Repairing electronic systems in vehicles
-- Automotive,	Automotive Paint and Coating Manufacturing,	Producing paint and coatings for vehicles
-- Automotive,	Automotive Parts,	Manufacturing components for vehicles
-- Automotive,	Automotive Rental,	Renting vehicles to individuals and businesses
-- Automotive,	Automotive Repair and Maintenance,	Vehicle maintenance and repair services
-- Automotive,	Automotive Retail,	Selling vehicles to consumers
-- Automotive,	Automotive Safety,	Developing safety features for vehicles
-- Automotive,	Automotive Testing and Certification,	Testing and certifying automotive components
-- Automotive,	Autonomous Vehicles,	Self-driving cars and transportation technologies
-- Automotive,	Car Dealerships,	Selling new and used vehicles
-- Automotive,	Car Rental Services,	Renting vehicles to customers
-- Automotive,	Car Sharing Services,	Renting cars for short periods
-- Automotive,	Electric Vehicle Charging Stations,	Charging stations for electric vehicles
-- Automotive,	Electric Vehicles,	Manufacturing and selling EVs
-- Automotive,	Tire Manufacturing,	Producing tires for vehicles
-- Automotive,	Vehicle Insurance,	Insurance coverage for automobiles
-- Banking and Financial Services,	Credit Card Issuers,	Providing credit cards to consumers
-- Banking and Financial Services,	Credit Unions,	Member-owned financial cooperatives
-- Banking and Financial Services,	Financial Planning,	Providing financial advice and planning
-- Banking and Financial Services,	Forex Trading,	Trading foreign currencies and currencies markets
-- Banking and Financial Services,	Investment Banking,	Assisting with raising capital and M&A deals
-- Banking and Financial Services,	Investment Management,	Managing investment portfolios and assets
-- Banking and Financial Services,	Mortgage Services,	Offering loans for purchasing real estate
-- Banking and Financial Services,	Online Banking,	Digital banking services and transactions
-- Banking and Financial Services,	Retail Banking,	Providing financial services to individual clients
-- Banking and Financial Services,	Wealth Management,	Managing and growing wealth for high-net-worth individuals
-- Construction,	Architecture and Engineering,	Designing and planning construction projects
-- Construction,	Building Construction,	Constructing commercial and residential buildings
-- Construction,	Building Materials,	Manufacturing construction materials
-- Construction,	Building Materials Retail,	Selling construction materials to consumers
-- Construction,	Civil and Infrastructure Engineering,	Designing and planning infrastructure projects
-- Construction,	Civil Engineering,	Designing and planning infrastructure projects
-- Construction,	Commercial Construction,	Constructing office buildings and commercial spaces
-- Construction,	Construction Management,	Overseeing and managing construction projects
-- Construction,	Demolition,	Dismantling and removing structures
-- Construction,	Electrical Services,	Installing and maintaining electrical systems
-- Construction,	General Contractors,	Overseeing construction projects
-- Construction,	Green Building,	Sustainable and eco-friendly building practices
-- Construction,	Green Building Certification,	Certifying environmentally friendly buildings
-- Construction,	Heavy Equipment,	Machinery used in construction
-- Construction,	Land Development,	Transforming raw land for construction purposes
-- Construction,	Plumbing Services,	Installing and repairing plumbing systems
-- Construction,	Residential Construction,	Building homes and residential properties
-- Construction,	Road and Bridge Construction,	Building roads, highways, and bridges
-- Construction,	Road Construction,	Building and maintaining roads and highways
-- Construction,	Road Maintenance,	Repairing and maintaining roads and highways
-- Education,	Adult Education,	Education programs for adult learners
-- Education,	Early Childhood Education,	Education for young children
-- Education,	Education Consultancy,	Providing advice and guidance on education
-- Education,	Educational Assessment,	Evaluating students' academic performance
-- Education,	Educational Content Licensing,	Licensing educational content for distribution
-- Education,	Educational Publishing,	Producing educational materials
-- Education,	Educational Software Development,	Creating software for educational purposes
-- Education,	Educational Technology,	Integrating technology into education
-- Education,	Educational Testing and Assessment,	Assessing and evaluating educational performance
-- Education,	Language Learning Apps,	Mobile apps for learning new languages
-- Education,	Language Schools,	Teaching languages to students and professionals
-- Education,	Online Course Platforms,	E-learning platforms for online courses
-- Education,	Online Education,	E-learning platforms and courses
-- Education,	Online Learning Platforms,	E-learning platforms for online education
-- Education,	Online Tutoring,	Remote teaching and support for students
-- Education,	Schools and Universities,	Providing formal education
-- Education,	Special Education,	Education for students with special needs
-- Education,	Tutoring,	One-on-one teaching and assistance
-- Education,	Vocational Training,	Practical training for specific skills
-- Energy,	Electricity Generation and Distribution,	Producing and delivering electricity
-- Energy,	Energy Storage,	Storing energy for later use
-- Energy,	Nuclear Power,	Generating electricity through nuclear reactions
-- Energy,	Oil and Gas,	Exploration, extraction, and refining of oil/gas
-- Energy,	Renewable Energy,	Solar, wind, hydroelectric, and other renewables
-- Energy and Utilities,	Battery Storage Systems,	Storing energy from renewable sources
-- Energy and Utilities,	Biofuel Production,	Producing renewable fuel from biological sources
-- Energy and Utilities,	Biomass Energy,	Generating energy from organic materials
-- Energy and Utilities,	Carbon Capture and Storage (CCS),	Capturing and storing carbon emissions
-- Energy and Utilities,	Electric Power Transmission and Distribution,	Transmitting and distributing electricity
-- Energy and Utilities,	Electric Utilities,	Producing and distributing electricity
-- Energy and Utilities,	Energy Efficiency Consulting,	Advising on energy-saving measures
-- Energy and Utilities,	Energy Storage Solutions,	Technologies and systems for storing energy
-- Energy and Utilities,	Geothermal Energy,	Harnessing heat from the Earth's interior
-- Energy and Utilities,	Hydroelectric Power,	Generating electricity from flowing water
-- Energy and Utilities,	Hydropower Generation,	Generating electricity from flowing water
-- Energy and Utilities,	Natural Gas,	Producing and distributing natural gas
-- Energy and Utilities,	Natural Gas Distribution,	Transporting and distributing natural gas
-- Energy and Utilities,	Nuclear Energy,	Generating electricity from nuclear reactions
-- Energy and Utilities,	Nuclear Energy Consulting,	Providing expertise on nuclear energy projects
-- Energy and Utilities,	Offshore Wind Energy,	Harnessing wind power from offshore locations
-- Energy and Utilities,	Oil and Gas Services,	Supporting operations in the oil and gas industry
-- Energy and Utilities,	Oilfield Services,	Providing services to the oil and gas industry
-- Energy and Utilities,	Power Generation Equipment,	Manufacturing equipment for power generation
-- Energy and Utilities,	Renewable Energy Certificates (RECs),	Tradable certificates representing green energy
-- Energy and Utilities,	Renewable Energy Financing,	Financing projects related to renewable energy
-- Energy and Utilities,	Smart Grid Technology,	Modernizing and optimizing electricity grids
-- Energy and Utilities,	Smart Metering,	Monitoring and managing energy consumption
-- Energy and Utilities,	Solar Panel Manufacturing,	Producing solar panels for renewable energy
-- Energy and Utilities,	Waste Management,	Handling and disposing of waste materials
-- Energy and Utilities,	Water and Wastewater,	Treatment and distribution of water
-- Energy and Utilities,	Water Treatment,	Purifying and treating water for consumption
-- Energy and Utilities,	Water Utilities,	Supplying and treating water for public use
-- Energy and Utilities,	Wave and Tidal Energy,	Generating electricity from waves and tides
-- Energy and Utilities,	Wind Power,	Generating electricity from wind
-- Entertainment and Media,	Film and Television Production,	Creating movies and TV shows
-- Entertainment and Media,	Gaming,	Video games development and distribution
-- Entertainment and Media,	Music,	Producing and distributing music
-- Entertainment and Media,	Publishing,	Producing and distributing written content
-- Entertainment and Media,	Social Media Platforms,	Online platforms for sharing content
-- Environmental Services,	Climate Change Consulting,	Providing expertise on climate change issues
-- Environmental Services,	Conservation Organizations,	Protecting and preserving natural resources
-- Environmental Services,	Ecological Consulting,	Advising on ecological and environmental issues
-- Environmental Services,	Environmental Compliance,	Ensuring adherence to environmental regulations
-- Environmental Services,	Environmental Conservation,	Protecting and preserving natural resources
-- Environmental Services,	Environmental Consulting,	Providing expertise on environmental issues
-- Environmental Services,	Environmental Impact Assessment,	Assessing environmental impacts of projects
-- Environmental Services,	Environmental Monitoring,	Measuring and analyzing environmental conditions
-- Environmental Services,	Environmental Remediation,	Cleaning up and restoring contaminated sites
-- Environmental Services,	Environmental Restoration,	Restoring ecosystems and natural habitats
-- Environmental Services,	Pollution Control,	Reducing and preventing pollution
-- Environmental Services,	Pollution Monitoring,	Measuring and analyzing pollution levels
-- Environmental Services,	Renewable Energy Consulting,	Providing expertise on renewable energy projects
-- Environmental Services,	Renewable Resource Management,	Sustainable use of natural resources
-- Environmental Services,	Sustainable Waste Management,	Implementing eco-friendly waste management
-- Environmental Services,	Waste Recycling,	Processing and reusing waste materials
-- Environmental Services,	Waste-to-Energy,	Generating energy from waste materials
-- Fashion and Beauty,	Beauty Product Retailers,	Stores selling cosmetics and beauty products
-- Fashion and Beauty,	Beauty Salons and Spas,	Providing beauty and wellness services
-- Fashion and Beauty,	Cosmetics,	Makeup, skincare, and beauty products
-- Fashion and Beauty,	Fashion Accessories,	Producing accessories like bags, jewelry, etc.
-- Fashion and Beauty,	Fashion Design,	Creating clothing and accessory designs
-- Fashion and Beauty,	Fashion Design and Manufacturing,	Creating and producing clothing designs
-- Fashion and Beauty,	Fashion E-commerce,	Online retail platforms for fashion products
-- Fashion and Beauty,	Fashion Events and Shows,	Organizing fashion events and runway shows
-- Fashion and Beauty,	Fashion Retail,	Selling clothing and accessories to consumers
-- Fashion and Beauty,	Fashion Retailers,	Retail stores selling clothing and accessories
-- Fashion and Beauty,	Hair Salons,	Providing hair styling and treatments
-- Fashion and Beauty,	Haircare Products,	Shampoos, conditioners, and hair styling products
-- Fashion and Beauty,	Luxury Beauty,	High-end and exclusive beauty products
-- Fashion and Beauty,	Luxury Fashion,	High-end and exclusive clothing and accessories
-- Fashion and Beauty,	Makeup Artists,	Providing makeup services for events and media
-- Fashion and Beauty,	Perfumes and Fragrances,	Manufacturing and selling scented products
-- Fashion and Beauty,	Personal Care Products,	Hygiene and personal care items
-- Fashion and Beauty,	Personal Styling,	Providing fashion and style advice to clients
-- Fashion and Beauty,	Skincare Products,	Products for skincare and skin health
-- Fashion and Beauty,	Sustainable Fashion,	Environmentally friendly and ethical fashion
-- Finance,	Accounting,	Financial record-keeping and reporting
-- Finance,	Asset Management,	Managing investment portfolios
-- Finance,	Banking,	Accepting deposits and lending money
-- Finance,	Insurance,	Risk management and protection
-- Food and Beverage,	Beverages,	Manufacturing and distributing drinks
-- Food and Beverage,	Brewery,	Beer production and distribution
-- Food and Beverage,	Food Processing,	Preparing and packaging food products
-- Food and Beverage,	Restaurants and Cafes,	Food service establishments for dining
-- Food and Beverage,	Snack Foods,	Producing and selling snacks and confectionery
-- Healthcare,	Biomedical Engineering,	Applying engineering principles to medical fields
-- Healthcare,	Biotechnology,	Utilizing biological systems in medical research
-- Healthcare,	Healthcare Analytics,	Analyzing healthcare data for insights
-- Healthcare,	Healthcare Compliance,	Ensuring adherence to healthcare regulations
-- Healthcare,	Healthcare Consulting,	Advising and improving healthcare facilities
-- Healthcare,	Healthcare Information Systems,	Managing and storing electronic health records
-- Healthcare,	Healthcare IT,	Information technology in healthcare
-- Healthcare,	Healthcare Software,	Developing software solutions for healthcare
-- Healthcare,	Home Care Services,	Medical and non-medical care at home
-- Healthcare,	Home Healthcare,	Medical services provided in patients' homes
-- Healthcare,	Home Medical Equipment,	Providing medical equipment for home use
-- Healthcare,	Hospitals,	Providing medical services to patients
-- Healthcare,	Medical Devices,	Producing medical equipment and devices
-- Healthcare,	Medical Equipment Leasing,	Renting medical devices and equipment
-- Healthcare,	Medical Equipment Manufacturing,	Producing medical instruments and devices
-- Healthcare,	Medical Imaging,	Techniques for visualizing the human body
-- Healthcare,	Medical Laboratories,	Testing and analyzing medical samples
-- Healthcare,	Mental Health Counseling,	Providing therapy and counseling services
-- Healthcare,	Mental Health Services,	Providing psychological and psychiatric care
-- Healthcare,	Nursing Care Facilities,	Residential care for elderly or disabled patients
-- Healthcare,	Pharmaceutical Wholesale,	Distributing medications to pharmacies
-- Healthcare,	Pharmaceuticals,	Drug development and manufacturing
-- Healthcare,	Physical Therapy,	Rehabilitation and treatment for injuries
-- Healthcare,	Radiology,	Medical imaging and diagnostics
-- Healthcare,	Telehealth Services,	Providing medical services remotely
-- Hospitality and Leisure,	Amusement Parks and Attractions,	Theme parks and recreational facilities
-- Hospitality and Leisure,	Bed and Breakfasts,	Accommodation with breakfast provided
-- Hospitality and Leisure,	Bed and Mattress Manufacturing,	Producing beds and mattresses for hospitality
-- Hospitality and Leisure,	Camping and RV Parks,	Outdoor camping and recreational vehicle parks
-- Hospitality and Leisure,	Casino Hotels,	Hotels with attached casinos
-- Hospitality and Leisure,	Casinos,	Gaming and entertainment venues
-- Hospitality and Leisure,	Cruise Lines,	Operating cruise ships for leisure travel
-- Hospitality and Leisure,	Cruise Ship Services,	Services offered onboard cruise ships
-- Hospitality and Leisure,	Entertainment Events,	Organizing concerts, shows, and entertainment events
-- Hospitality and Leisure,	Event Management,	Planning and organizing events and functions
-- Hospitality and Leisure,	Event Planning,	Organizing and coordinating events
-- Hospitality and Leisure,	Gaming and Casinos,	Gambling and casino entertainment
-- Hospitality and Leisure,	Golf Courses,	Recreation and sports facilities for golfing
-- Hospitality and Leisure,	Hotel Management,	Managing operations and services in hotels
-- Hospitality and Leisure,	Hotels and Resorts,	Providing accommodation and hospitality services
-- Hospitality and Leisure,	Nightclubs and Bars,	Entertainment venues for nightlife
-- Hospitality and Leisure,	Resort Management,	Managing leisure resorts and vacation destinations
-- Hospitality and Leisure,	Restaurants and Bars,	Food and beverage establishments
-- Hospitality and Leisure,	Spa and Wellness Centers,	Providing relaxation and health treatments
-- Hospitality and Leisure,	Sports and Entertainment Venues,	Arenas, stadiums, and event venues
-- Hospitality and Leisure,	Sports and Fitness Centers,	Facilities for sports and fitness activities
-- Hospitality and Leisure,	Theme Parks,	Amusement parks with themed attractions
-- Hospitality and Leisure,	Theme Restaurants,	Restaurants with unique themes and experiences
-- Hospitality and Leisure,	Tour Operators,	Organizing and conducting guided tours
-- Hospitality and Leisure,	Travel Agencies,	Assisting travelers with trip planning
-- Information Technology,	Cloud Computing,	Storing and accessing data over the internet
-- Information Technology,	Cybersecurity,	Protecting systems and data from cyber threats
-- Information Technology,	Data Analytics,	Analyzing and interpreting data for insights
-- Information Technology,	IT Consulting,	Providing advice and solutions for IT projects
-- Information Technology,	Software as a Service (SaaS),	Offering software on a subscription basis
-- Insurance,	Auto Insurance,	Insuring against damages and accidents
-- Insurance,	Aviation Insurance,	Coverage for aviation risks and liabilities
-- Insurance,	Business Insurance,	Insurance coverage for businesses
-- Insurance,	Business Interruption Insurance,	Coverage for lost income due to business disruption
-- Insurance,	Captive Insurance,	Self-insurance by a group of affiliated companies
-- Insurance,	Commercial Insurance,	Insurance for businesses and commercial entities
-- Insurance,	Crop Insurance,	Insurance for agricultural losses and risks
-- Insurance,	Cyber Insurance,	Protecting against cyber-related risks
-- Insurance,	Cyber Liability Insurance,	Protection against cyber-related risks
-- Insurance,	Health Insurance,	Coverage for medical expenses and treatments
-- Insurance,	Health Reimbursement Arrangements (HRAs),	Employer-funded health expense reimbursements
-- Insurance,	Health Savings Accounts (HSAs),	Tax-advantaged accounts for medical expenses
-- Insurance,	Home Insurance,	Insurance coverage for homeowners
-- Insurance,	Liability Insurance,	Coverage for legal liabilities and lawsuits
-- Insurance,	Life Insurance,	Offering protection against loss of life
-- Insurance,	Pet Insurance,	Covering veterinary expenses for pets
-- Insurance,	Professional Liability Insurance,	Protecting against professional errors and omissions
-- Insurance,	Property and Casualty Insurance,	Protecting against property damage and liability
-- Insurance,	Reinsurance,	Insurance for insurance companies
-- Insurance,	Title Insurance,	Ensuring property ownership and title clarity
-- Mining and Metals,	Aluminum Production,	Manufacturing aluminum and aluminum products
-- Mining and Metals,	Coal Mining,	Extracting coal from the ground
-- Mining and Metals,	Copper Mining,	Extracting copper from ore
-- Mining and Metals,	Diamond Mining,	Extracting diamonds from mines
-- Mining and Metals,	Gold and Precious Metals,	Mining and refining precious metals
-- Mining and Metals,	Iron and Steel,	Producing iron and steel products
-- Mining and Metals,	Rare Earth Metals,	Mining and processing rare earth elements
-- Mining and Metals,	Silver Mining,	Extracting silver from ore
-- Mining and Metals,	Steel Manufacturing,	Producing steel from iron ore
-- Mining and Metals,	Zinc Mining,	Extracting zinc from ore
-- Mining and Metals,	,	
-- Pharmaceuticals,	Biopharmaceuticals,	Using living organisms for medical treatments
-- Pharmaceuticals,	Drug Distribution,	Supplying medications to pharmacies
-- Pharmaceuticals,	Generic Drugs,	Affordable alternatives to brand-name drugs
-- Pharmaceuticals,	Over-the-Counter (OTC) Drugs,	Medications available without a prescription
-- Pharmaceuticals,	Vaccines,	Immunizing against infectious diseases
-- Pharmaceuticals and Biotechnology,	Antibody Therapeutics,	Using antibodies as therapeutic agents
-- Pharmaceuticals and Biotechnology,	Biomedical Research,	Research on human health and diseases
-- Pharmaceuticals and Biotechnology,	Biopharmaceutical Manufacturing,	Producing drugs using biological processes
-- Pharmaceuticals and Biotechnology,	Clinical Research,	Conducting trials and studies for drug efficacy
-- Pharmaceuticals and Biotechnology,	Contract Manufacturing,	Outsourcing manufacturing for pharmaceuticals
-- Pharmaceuticals and Biotechnology,	Contract Research Organizations (CROs),	Outsourcing research and development activities
-- Pharmaceuticals and Biotechnology,	Diagnostic Equipment,	Manufacturing medical devices for diagnosis
-- Pharmaceuticals and Biotechnology,	Drug Discovery,	Identifying and developing new medications
-- Pharmaceuticals and Biotechnology,	Drug Discovery and Development,	Researching and developing new medications
-- Pharmaceuticals and Biotechnology,	Drug Manufacturing,	Producing medications and pharmaceuticals
-- Pharmaceuticals and Biotechnology,	Gene Therapy,	Treating or preventing diseases with gene manipulation
-- Pharmaceuticals and Biotechnology,	Genetic Engineering,	Manipulating genes for medical purposes
-- Pharmaceuticals and Biotechnology,	Medical Research,	Conducting research on diseases and treatments
-- Pharmaceuticals and Biotechnology,	Nanotechnology in Medicine,	Applying nanoscale materials in medical treatments
-- Pharmaceuticals and Biotechnology,	Personalized Medicine,	Tailoring medical treatment to individuals
-- Pharmaceuticals and Biotechnology,	Pharmaceutical Distribution,	Supplying medications to pharmacies and hospitals
-- Pharmaceuticals and Biotechnology,	Pharmaceutical Packaging,	Packaging and labeling pharmaceutical products
-- Pharmaceuticals and Biotechnology,	Pharmaceutical Testing,	Conducting clinical trials for drugs and vaccines
-- Pharmaceuticals and Biotechnology,	Pharmacogenomics,	Studying the role of genetics in drug response
-- Pharmaceuticals and Biotechnology,	Regenerative Medicine,	Restoring damaged tissues and organs
-- Pharmaceuticals and Biotechnology,	Regulatory Affairs,	Ensuring compliance with pharmaceutical regulations
-- Pharmaceuticals and Biotechnology,	Vaccination Development,	Developing vaccines for diseases
-- Real Estate,	Commercial Real Estate,	Office buildings, retail spaces, etc.
-- Real Estate,	Property Management,	Managing and maintaining properties
-- Real Estate,	Real Estate Development,	Developing new real estate projects
-- Real Estate,	Real Estate Investment,	Investing in properties for returns
-- Real Estate,	Residential Real Estate,	Buying and selling homes and properties
-- Retail,	Apparel and Accessories Retail,	Selling clothing, shoes, and accessories
-- Retail,	Convenience Stores,	Small stores with extended hours and convenience
-- Retail,	Department Stores,	Large retail stores with various product lines
-- Retail,	Electronics and Appliance Retail,	Selling electronic devices and home appliances
-- Retail,	Food and Beverage Retail,	Selling food products and beverages
-- Retail,	Luxury Retail,	High-end products and personalized service
-- Retail,	Online Marketplaces,	E-commerce platforms connecting buyers and sellers
-- Retail,	Online Retail,	E-commerce platforms for selling products
-- Retail,	Specialty Stores,	Focused on specific product categories
-- Retail,	Supermarkets,	Large grocery stores
-- Technology,	Artificial Intelligence,	Developing AI systems and applications
-- Technology,	E-commerce,	Online buying and selling of goods and services
-- Technology,	Hardware Manufacturing,	Production of computer hardware components
-- Technology,	Software Development,	Creating and maintaining software applications
-- Technology,	Telecommunications,	Network infrastructure and communication services
-- Telecommunications,	Internet Service Providers (ISPs),	Providing internet access to customers
-- Telecommunications,	Mobile Network Operators,	Operating wireless communication networks
-- Telecommunications,	Satellite Communication,	Transmitting signals via satellites
-- Telecommunications,	Telecommunication Equipment,	Manufacturing communication devices
-- Telecommunications,	VoIP (Voice over Internet Protocol),	Making phone calls over the internet
-- Textile,	Apparel Manufacturing,	Making clothing and accessories
-- Textile,	Carpet and Rug Manufacturing,	Making carpets and rugs
-- Textile,	Clothing and Fabric Retail,	Selling clothes and fabrics
-- Textile,	Textile Mills,	Producing fabrics and textiles
-- Textile,	Textile Recycling,	Reprocessing and reusing textile materials
-- Tourism,	Adventure Tourism,	Exciting and unconventional travel experiences
-- Tourism,	Cruises,	Vacation trips on cruise ships
-- Tourism,	Hotels,	Providing accommodation for travelers
-- Tourism,	Tourist Attractions,	Popular destinations for visitors
-- Tourism,	Travel Agencies,	Assisting travelers with trip planning
-- Transportation,	Air Freight and Cargo,	Transporting goods by air
-- Transportation,	Airline Services,	Operating scheduled air transportation services
-- Transportation,	Airport Operations,	Managing and operating airports

-- create call statements to insert these sub-industries using the stored procedure sp_insert_subindustry in mysql
call sp_insert_subindustry('Advertising and Marketing','Advertising Agencies','Creating and implementing ad campaigns');
call sp_insert_subindustry('Advertising and Marketing','Affiliate Marketing','Promoting products through affiliates');
call sp_insert_subindustry('Advertising and Marketing','Brand Strategy and Positioning','Developing brand identity and market positioning');
call sp_insert_subindustry('Advertising and Marketing','Branding and Identity','Creating and managing brand image and identity');
call sp_insert_subindustry('Advertising and Marketing','Content Creation','Producing creative content for marketing');
call sp_insert_subindustry('Advertising and Marketing','Content Marketing','Creating and distributing valuable content');
call sp_insert_subindustry('Advertising and Marketing','Digital Advertising Networks','Online advertising networks and platforms');
call sp_insert_subindustry('Advertising and Marketing','Digital Marketing','Online marketing strategies and campaigns');
call sp_insert_subindustry('Advertising and Marketing','Direct Mail Advertising','Sending promotional materials via mail');
call sp_insert_subindustry('Advertising and Marketing','Email Marketing','Promoting products and services via email');
call sp_insert_subindustry('Advertising and Marketing','Email Newsletter Marketing','Sending promotional emails to subscribers');
call sp_insert_subindustry('Advertising and Marketing','Event Marketing','Promoting products and services at events');
call sp_insert_subindustry('Advertising and Marketing','Guerilla Marketing','Unconventional and creative marketing strategies');
call sp_insert_subindustry('Advertising and Marketing','Influencer Marketing','Promoting products through influential individuals');
call sp_insert_subindustry('Advertising and Marketing','Influencer Networks','Connecting brands with social media influencers');
call sp_insert_subindustry('Advertising and Marketing','Market Analysis and Research','Conducting research to understand markets');
call sp_insert_subindustry('Advertising and Marketing','Market Research','Gathering and analyzing consumer data');
call sp_insert_subindustry('Advertising and Marketing','Mobile Advertising','Advertising on mobile devices');
call sp_insert_subindustry('Advertising and Marketing','Native Advertising','Blending ads with the surrounding content');
call sp_insert_subindustry('Advertising and Marketing','Outdoor Advertising','Billboards, transit ads, and other outdoor media');
call sp_insert_subindustry('Advertising and Marketing','Print Advertising','Traditional print media for advertising');
call sp_insert_subindustry('Advertising and Marketing','Public Relations','Managing communications and reputation');
call sp_insert_subindustry('Advertising and Marketing','Search Engine Marketing (SEM)','Paid advertising on search engines');
call sp_insert_subindustry('Advertising and Marketing','Search Engine Optimization (SEO)','Improving website visibility in search engines');
call sp_insert_subindustry('Advertising and Marketing','Social Media Management','Managing social media presence and interactions');
call sp_insert_subindustry('Advertising and Marketing','Social Media Marketing','Promoting brands and products on social media');
call sp_insert_subindustry('Advertising and Marketing','Video Advertising','Advertising through online video content');
call sp_insert_subindustry('Aerospace and Aviation','Aerospace Engineering','Designing and developing aerospace technologies');
call sp_insert_subindustry('Aerospace and Aviation','Aerospace Materials','Manufacturing materials used in aerospace');
call sp_insert_subindustry('Aerospace and Aviation','Air Cargo Services','Transporting cargo by air');
call sp_insert_subindustry('Aerospace and Aviation','Air Freight Services','Transporting cargo by air');
call sp_insert_subindustry('Aerospace and Aviation','Air Traffic Control','Managing and directing air traffic');
call sp_insert_subindustry('Aerospace and Aviation','Air Traffic Management','Controlling air traffic for safe operations');
call sp_insert_subindustry('Aerospace and Aviation','Aircraft Leasing','Renting out aircraft to airlines and operators');
call sp_insert_subindustry('Aerospace and Aviation','Aircraft Leasing and Financing','Leasing and financing aircraft');
call sp_insert_subindustry('Aerospace and Aviation','Aircraft Maintenance Repair and Overhaul','Servicing and repairing aircraft');
call sp_insert_subindustry('Aerospace and Aviation','Aircraft Manufacturing','Producing various types of aircraft');
call sp_insert_subindustry('Aerospace and Aviation','Aircraft Parts Manufacturing','Producing components for aircraft');
call sp_insert_subindustry('Aerospace and Aviation','Airfreight and Cargo','Transporting goods by air');
call sp_insert_subindustry('Aerospace and Aviation','Airline Services','Operating scheduled air transportation services');
call sp_insert_subindustry('Aerospace and Aviation','Airport Operations','Managing and operating airports');
call sp_insert_subindustry('Aerospace and Aviation','Aviation Consulting','Providing expertise on aviation projects');
call sp_insert_subindustry('Aerospace and Aviation','Aviation Maintenance','Repair and maintenance of aircraft');
call sp_insert_subindustry('Aerospace and Aviation','Aviation Training','Providing training for pilots and aviation staff');
call sp_insert_subindustry('Aerospace and Aviation','Avionics Manufacturing','Designing and manufacturing aviation electronics');
call sp_insert_subindustry('Aerospace and Aviation','Commercial Airlines','Passenger air transportation services');
call sp_insert_subindustry('Aerospace and Aviation','Flight Training','Providing pilot and crew training');
call sp_insert_subindustry('Aerospace and Aviation','Private Aviation','Private jet services and charters');
call sp_insert_subindustry('Aerospace and Aviation','Satellite Technology','Developing and launching satellites');
call sp_insert_subindustry('Aerospace and Aviation','Space Tourism','Commercial space travel and tourism');
call sp_insert_subindustry('Aerospace and Aviation','Spacecraft Design and Engineering','Designing spacecraft and satellite technologies');
call sp_insert_subindustry('Aerospace and Aviation','Spacecraft Manufacturing','Building spacecraft and satellite technologies');
call sp_insert_subindustry('Aerospace and Defense','Aerospace Manufacturing','Producing aircraft, spacecraft, and related parts');
call sp_insert_subindustry('Aerospace and Defense','Defense Contractors','Providing products and services to the military');
call sp_insert_subindustry('Aerospace and Defense','Military Technology','Developing technology for military applications');
call sp_insert_subindustry('Aerospace and Defense','Satellite Services','Communication and observation via satellites');
call sp_insert_subindustry('Aerospace and Defense','Space Exploration','Research and exploration beyond Earths atmosphere');
call sp_insert_subindustry('Agriculture','Agribusiness','Integrated farming and agricultural industries');
call sp_insert_subindustry('Agriculture','Agricultural Equipment Rental','Renting farm machinery and equipment');
call sp_insert_subindustry('Agriculture','Agricultural Machinery Leasing','Renting agricultural equipment and machinery');
call sp_insert_subindustry('Agriculture','Agricultural Machinery Manufacturing','Producing equipment for agriculture');
call sp_insert_subindustry('Agriculture','Agricultural Research','Advancing agricultural practices through research');
call sp_insert_subindustry('Agriculture','Agrochemicals','Chemical products used in agriculture');
call sp_insert_subindustry('Agriculture','Agroforestry','Integrating trees and agriculture practices');
call sp_insert_subindustry('Agriculture','Aquaculture','Cultivating aquatic organisms for consumption');
call sp_insert_subindustry('Agriculture','Aquaponics','Combining aquaculture and hydroponics for farming');
call sp_insert_subindustry('Agriculture','Aquatic Farming','Cultivating aquatic plants and animals');
call sp_insert_subindustry('Agriculture','Crop Production','Growing and harvesting agricultural crops');
call sp_insert_subindustry('Agriculture','Grain and Oilseed Milling','Processing grains and oilseeds into products');
call sp_insert_subindustry('Agriculture','Greenhouse Farming','Cultivating crops in controlled environments');
call sp_insert_subindustry('Agriculture','Horticulture','Cultivating and managing gardens and landscapes');
call sp_insert_subindustry('Agriculture','Irrigation Systems','Supplying water to crops and farmlands');
call sp_insert_subindustry('Agriculture','Livestock Farming','Raising animals for food and other products');
call sp_insert_subindustry('Agriculture','Livestock Feed Additives','Supplements for animal feed');
call sp_insert_subindustry('Agriculture','Livestock Feed Manufacturing','Producing feed for livestock and animals');
call sp_insert_subindustry('Agriculture','Precision Agriculture','Using technology for optimized farming');
call sp_insert_subindustry('Agriculture','Seed Production','Producing and distributing agricultural seeds');
call sp_insert_subindustry('Automotive','Auto Body Repair','Restoring and repairing vehicle bodies');
call sp_insert_subindustry('Automotive','Automobile Manufacturing','Producing cars, trucks, and motorcycles');
call sp_insert_subindustry('Automotive','Automotive Aftermarket','Providing vehicle parts and accessories');
call sp_insert_subindustry('Automotive','Automotive Dealerships','Retailing new and used vehicles');
call sp_insert_subindustry('Automotive','Automotive Design and Engineering','Designing vehicles and their components');
call sp_insert_subindustry('Automotive','Automotive Design and Styling','Styling and shaping the appearance of vehicles');
call sp_insert_subindustry('Automotive','Automotive Electronics','Manufacturing electronic components for vehicles');
call sp_insert_subindustry('Automotive','Automotive Electronics Repair','Repairing electronic systems in vehicles');
call sp_insert_subindustry('Automotive','Automotive Paint and Coating Manufacturing','Producing paint and coatings for vehicles');
call sp_insert_subindustry('Automotive','Automotive Parts','Manufacturing components for vehicles');
call sp_insert_subindustry('Automotive','Automotive Rental','Renting vehicles to individuals and businesses');
call sp_insert_subindustry('Automotive','Automotive Repair and Maintenance','Vehicle maintenance and repair services');
call sp_insert_subindustry('Automotive','Automotive Retail','Selling vehicles to consumers');
call sp_insert_subindustry('Automotive','Automotive Safety','Developing safety features for vehicles');
call sp_insert_subindustry('Automotive','Automotive Testing and Certification','Testing and certifying automotive components');
call sp_insert_subindustry('Automotive','Autonomous Vehicles','Self-driving cars and transportation technologies');
call sp_insert_subindustry('Automotive','Car Dealerships','Selling new and used vehicles');
call sp_insert_subindustry('Automotive','Car Rental Services','Renting vehicles to customers');
call sp_insert_subindustry('Automotive','Car Sharing Services','Renting cars for short periods');
call sp_insert_subindustry('Automotive','Electric Vehicle Charging Stations','Charging stations for electric vehicles');
call sp_insert_subindustry('Automotive','Electric Vehicles','Manufacturing and selling EVs');
call sp_insert_subindustry('Automotive','Tire Manufacturing','Producing tires for vehicles');
call sp_insert_subindustry('Automotive','Vehicle Insurance','Insurance coverage for automobiles');
call sp_insert_subindustry('Banking and Financial Services','Credit Card Issuers','Providing credit cards to consumers');
call sp_insert_subindustry('Banking and Financial Services','Credit Unions','Member-owned financial cooperatives');
call sp_insert_subindustry('Banking and Financial Services','Financial Planning','Providing financial advice and planning');
call sp_insert_subindustry('Banking and Financial Services','Forex Trading','Trading foreign currencies and currencies markets');
call sp_insert_subindustry('Banking and Financial Services','Investment Banking','Assisting with raising capital and M&A deals');
call sp_insert_subindustry('Banking and Financial Services','Investment Management','Managing investment portfolios and assets');
call sp_insert_subindustry('Banking and Financial Services','Mortgage Services','Offering loans for purchasing real estate');
call sp_insert_subindustry('Banking and Financial Services','Online Banking','Digital banking services and transactions');
call sp_insert_subindustry('Banking and Financial Services','Retail Banking','Providing financial services to individual clients');
call sp_insert_subindustry('Banking and Financial Services','Wealth Management','Managing and growing wealth for high-net-worth individuals');
call sp_insert_subindustry('Construction','Architecture and Engineering','Designing and planning construction projects');
call sp_insert_subindustry('Construction','Building Construction','Constructing commercial and residential buildings');
call sp_insert_subindustry('Construction','Building Materials','Manufacturing construction materials');
call sp_insert_subindustry('Construction','Building Materials Retail','Selling construction materials to consumers');
call sp_insert_subindustry('Construction','Civil and Infrastructure Engineering','Designing and planning infrastructure projects');
call sp_insert_subindustry('Construction','Civil Engineering','Designing and planning infrastructure projects');
call sp_insert_subindustry('Construction','Commercial Construction','Constructing office buildings and commercial spaces');
call sp_insert_subindustry('Construction','Construction Management','Overseeing and managing construction projects');
call sp_insert_subindustry('Construction','Demolition','Dismantling and removing structures');
call sp_insert_subindustry('Construction','Electrical Services','Installing and maintaining electrical systems');
call sp_insert_subindustry('Construction','General Contractors','Overseeing construction projects');
call sp_insert_subindustry('Construction','Green Building','Sustainable and eco-friendly building practices');
call sp_insert_subindustry('Construction','Green Building Certification','Certifying environmentally friendly buildings');
call sp_insert_subindustry('Construction','Heavy Equipment','Machinery used in construction');
call sp_insert_subindustry('Construction','Land Development','Transforming raw land for construction purposes');
call sp_insert_subindustry('Construction','Plumbing Services','Installing and repairing plumbing systems');
call sp_insert_subindustry('Construction','Residential Construction','Building homes and residential properties');
call sp_insert_subindustry('Construction','Road and Bridge Construction','Building roads, highways, and bridges');
call sp_insert_subindustry('Construction','Road Construction','Building and maintaining roads and highways');
call sp_insert_subindustry('Construction','Road Maintenance','Repairing and maintaining roads and highways');
call sp_insert_subindustry('Education','Adult Education','Education programs for adult learners');
call sp_insert_subindustry('Education','Early Childhood Education','Education for young children');
call sp_insert_subindustry('Education','Education Consultancy','Providing advice and guidance on education');
call sp_insert_subindustry('Education','Educational Assessment','Evaluating students academic performance');
call sp_insert_subindustry('Education','Educational Content Licensing','Licensing educational content for distribution');
call sp_insert_subindustry('Education','Educational Publishing','Producing educational materials');
call sp_insert_subindustry('Education','Educational Software Development','Creating software for educational purposes');
call sp_insert_subindustry('Education','Educational Technology','Integrating technology into education');
call sp_insert_subindustry('Education','Educational Testing and Assessment','Assessing and evaluating educational performance');
call sp_insert_subindustry('Education','Language Learning Apps','Mobile apps for learning new languages');
call sp_insert_subindustry('Education','Language Schools','Teaching languages to students and professionals');
call sp_insert_subindustry('Education','Online Course Platforms','E-learning platforms for online courses');
call sp_insert_subindustry('Education','Online Education','E-learning platforms and courses');
call sp_insert_subindustry('Education','Online Learning Platforms','E-learning platforms for online education');
call sp_insert_subindustry('Education','Online Tutoring','Remote teaching and support for students');
call sp_insert_subindustry('Education','Schools and Universities','Providing formal education');
call sp_insert_subindustry('Education','Special Education','Education for students with special needs');
call sp_insert_subindustry('Education','Tutoring','One-on-one teaching and assistance');
call sp_insert_subindustry('Education','Vocational Training','Practical training for specific skills');
call sp_insert_subindustry('Energy','Electricity Generation and Distribution','Producing and delivering electricity');
call sp_insert_subindustry('Energy','Energy Storage','Storing energy for later use');
call sp_insert_subindustry('Energy','Nuclear Power','Generating electricity through nuclear reactions');
call sp_insert_subindustry('Energy','Oil and Gas','Exploration, extraction, and refining of oil/gas');
call sp_insert_subindustry('Energy','Renewable Energy','Solar, wind, hydroelectric, and other renewables');
call sp_insert_subindustry('Energy and Utilities','Battery Storage Systems','Storing energy from renewable sources');
call sp_insert_subindustry('Energy and Utilities','Biofuel Production','Producing renewable fuel from biological sources');
call sp_insert_subindustry('Energy and Utilities','Biomass Energy','Generating energy from organic materials');
call sp_insert_subindustry('Energy and Utilities','Carbon Capture and Storage (CCS)','Capturing and storing carbon emissions');
call sp_insert_subindustry('Energy and Utilities','Electric Power Transmission and Distribution','Transmitting and distributing electricity');
call sp_insert_subindustry('Energy and Utilities','Electric Utilities','Producing and distributing electricity');
call sp_insert_subindustry('Energy and Utilities','Energy Efficiency Consulting','Advising on energy-saving measures');
call sp_insert_subindustry('Energy and Utilities','Energy Storage Solutions','Technologies and systems for storing energy');
call sp_insert_subindustry('Energy and Utilities','Geothermal Energy','Harnessing heat from the Earths interior');
call sp_insert_subindustry('Energy and Utilities','Hydroelectric Power','Generating electricity from flowing water');
call sp_insert_subindustry('Energy and Utilities','Hydropower Generation','Generating electricity from flowing water');
call sp_insert_subindustry('Energy and Utilities','Natural Gas','Producing and distributing natural gas');
call sp_insert_subindustry('Energy and Utilities','Natural Gas Distribution','Transporting and distributing natural gas');
call sp_insert_subindustry('Energy and Utilities','Nuclear Energy','Generating electricity from nuclear reactions');
call sp_insert_subindustry('Energy and Utilities','Nuclear Energy Consulting','Providing expertise on nuclear energy projects');
call sp_insert_subindustry('Energy and Utilities','Offshore Wind Energy','Harnessing wind power from offshore locations');
call sp_insert_subindustry('Energy and Utilities','Oil and Gas Services','Supporting operations in the oil and gas industry');
call sp_insert_subindustry('Energy and Utilities','Oilfield Services','Providing services to the oil and gas industry');
call sp_insert_subindustry('Energy and Utilities','Power Generation Equipment','Manufacturing equipment for power generation');
call sp_insert_subindustry('Energy and Utilities','Renewable Energy Certificates (RECs)','Tradable certificates representing green energy');
call sp_insert_subindustry('Energy and Utilities','Renewable Energy Financing','Financing projects related to renewable energy');
call sp_insert_subindustry('Energy and Utilities','Smart Grid Technology','Modernizing and optimizing electricity grids');
call sp_insert_subindustry('Energy and Utilities','Smart Metering','Monitoring and managing energy consumption');
call sp_insert_subindustry('Energy and Utilities','Solar Panel Manufacturing','Producing solar panels for renewable energy');
call sp_insert_subindustry('Energy and Utilities','Waste Management','Handling and disposing of waste materials');
call sp_insert_subindustry('Energy and Utilities','Water and Wastewater','Treatment and distribution of water');
call sp_insert_subindustry('Energy and Utilities','Water Treatment','Purifying and treating water for consumption');
call sp_insert_subindustry('Energy and Utilities','Water Utilities','Supplying and treating water for public use');
call sp_insert_subindustry('Energy and Utilities','Wave and Tidal Energy','Generating electricity from waves and tides');
call sp_insert_subindustry('Energy and Utilities','Wind Power','Generating electricity from wind');
call sp_insert_subindustry('Entertainment and Media','Film and Television Production','Creating movies and TV shows');
call sp_insert_subindustry('Entertainment and Media','Gaming','Video games development and distribution');
call sp_insert_subindustry('Entertainment and Media','Music','Producing and distributing music');
call sp_insert_subindustry('Entertainment and Media','Publishing','Producing and distributing written content');
call sp_insert_subindustry('Entertainment and Media','Social Media Platforms','Online platforms for sharing content');
call sp_insert_subindustry('Environmental Services','Climate Change Consulting','Providing expertise on climate change issues');
call sp_insert_subindustry('Environmental Services','Conservation Organizations','Protecting and preserving natural resources');
call sp_insert_subindustry('Environmental Services','Ecological Consulting','Advising on ecological and environmental issues');
call sp_insert_subindustry('Environmental Services','Environmental Compliance','Ensuring adherence to environmental regulations');
call sp_insert_subindustry('Environmental Services','Environmental Conservation','Protecting and preserving natural resources');
call sp_insert_subindustry('Environmental Services','Environmental Consulting','Providing expertise on environmental issues');
call sp_insert_subindustry('Environmental Services','Environmental Impact Assessment','Assessing environmental impacts of projects');
call sp_insert_subindustry('Environmental Services','Environmental Monitoring','Measuring and analyzing environmental conditions');
call sp_insert_subindustry('Environmental Services','Environmental Remediation','Cleaning up and restoring contaminated sites');
call sp_insert_subindustry('Environmental Services','Environmental Restoration','Restoring ecosystems and natural habitats');
call sp_insert_subindustry('Environmental Services','Pollution Control','Reducing and preventing pollution');
call sp_insert_subindustry('Environmental Services','Pollution Monitoring','Measuring and analyzing pollution levels');
call sp_insert_subindustry('Environmental Services','Renewable Energy Consulting','Providing expertise on renewable energy projects');
call sp_insert_subindustry('Environmental Services','Renewable Resource Management','Sustainable use of natural resources');
call sp_insert_subindustry('Environmental Services','Sustainable Waste Management','Implementing eco-friendly waste management');
call sp_insert_subindustry('Environmental Services','Waste Recycling','Processing and reusing waste materials');
call sp_insert_subindustry('Environmental Services','Waste-to-Energy','Generating energy from waste materials');
call sp_insert_subindustry('Fashion and Beauty','Beauty Product Retailers','Stores selling cosmetics and beauty products');
call sp_insert_subindustry('Fashion and Beauty','Beauty Salons and Spas','Providing beauty and wellness services');
call sp_insert_subindustry('Fashion and Beauty','Cosmetics','Makeup, skincare, and beauty products');
call sp_insert_subindustry('Fashion and Beauty','Fashion Accessories','Producing accessories like bags, jewelry, etc.');
call sp_insert_subindustry('Fashion and Beauty','Fashion Design','Creating clothing and accessory designs');
call sp_insert_subindustry('Fashion and Beauty','Fashion Design and Manufacturing','Creating and producing clothing designs');
call sp_insert_subindustry('Fashion and Beauty','Fashion E-commerce','Online retail platforms for fashion products');
call sp_insert_subindustry('Fashion and Beauty','Fashion Events and Shows','Organizing fashion events and runway shows');
call sp_insert_subindustry('Fashion and Beauty','Fashion Retail','Selling clothing and accessories to consumers');
call sp_insert_subindustry('Fashion and Beauty','Fashion Retailers','Retail stores selling clothing and accessories');
call sp_insert_subindustry('Fashion and Beauty','Hair Salons','Providing hair styling and treatments');
call sp_insert_subindustry('Fashion and Beauty','Haircare Products','Shampoos, conditioners, and hair styling products');
call sp_insert_subindustry('Fashion and Beauty','Luxury Beauty','High-end and exclusive beauty products');
call sp_insert_subindustry('Fashion and Beauty','Luxury Fashion','High-end and exclusive clothing and accessories');
call sp_insert_subindustry('Fashion and Beauty','Makeup Artists','Providing makeup services for events and media');
call sp_insert_subindustry('Fashion and Beauty','Perfumes and Fragrances','Manufacturing and selling scented products');
call sp_insert_subindustry('Fashion and Beauty','Personal Care Products','Hygiene and personal care items');
call sp_insert_subindustry('Fashion and Beauty','Personal Styling','Providing fashion and style advice to clients');
call sp_insert_subindustry('Fashion and Beauty','Skincare Products','Products for skincare and skin health');
call sp_insert_subindustry('Fashion and Beauty','Sustainable Fashion','Environmentally friendly and ethical fashion');
call sp_insert_subindustry('Finance','Accounting','Financial record-keeping and reporting');
call sp_insert_subindustry('Finance','Asset Management','Managing investment portfolios');
call sp_insert_subindustry('Finance','Banking','Accepting deposits and lending money');
call sp_insert_subindustry('Finance','Insurance','Risk management and protection');
call sp_insert_subindustry('Food and Beverage','Beverages','Manufacturing and distributing drinks');
call sp_insert_subindustry('Food and Beverage','Brewery','Beer production and distribution');
call sp_insert_subindustry('Food and Beverage','Food Processing','Preparing and packaging food products');
call sp_insert_subindustry('Food and Beverage','Restaurants and Cafes','Food service establishments for dining');
call sp_insert_subindustry('Food and Beverage','Snack Foods','Producing and selling snacks and confectionery');
call sp_insert_subindustry('Healthcare','Biomedical Engineering','Applying engineering principles to medical fields');
call sp_insert_subindustry('Healthcare','Biotechnology','Utilizing biological systems in medical research');
call sp_insert_subindustry('Healthcare','Healthcare Analytics','Analyzing healthcare data for insights');
call sp_insert_subindustry('Healthcare','Healthcare Compliance','Ensuring adherence to healthcare regulations');
call sp_insert_subindustry('Healthcare','Healthcare Consulting','Advising and improving healthcare facilities');
call sp_insert_subindustry('Healthcare','Healthcare Information Systems','Managing and storing electronic health records');
call sp_insert_subindustry('Healthcare','Healthcare IT','Information technology in healthcare');
call sp_insert_subindustry('Healthcare','Healthcare Software','Developing software solutions for healthcare');
call sp_insert_subindustry('Healthcare','Home Care Services','Medical and non-medical care at home');
call sp_insert_subindustry('Healthcare','Home Healthcare','Medical services provided in patients homes');
call sp_insert_subindustry('Healthcare','Home Medical Equipment','Providing medical equipment for home use');
call sp_insert_subindustry('Healthcare','Hospitals','Providing medical services to patients');
call sp_insert_subindustry('Healthcare','Medical Devices','Producing medical equipment and devices');
call sp_insert_subindustry('Healthcare','Medical Equipment Leasing','Renting medical devices and equipment');
call sp_insert_subindustry('Healthcare','Medical Equipment Manufacturing','Producing medical instruments and devices');
call sp_insert_subindustry('Healthcare','Medical Imaging','Techniques for visualizing the human body');
call sp_insert_subindustry('Healthcare','Medical Laboratories','Testing and analyzing medical samples');
call sp_insert_subindustry('Healthcare','Mental Health Counseling','Providing therapy and counseling services');
call sp_insert_subindustry('Healthcare','Mental Health Services','Providing psychological and psychiatric care');
call sp_insert_subindustry('Healthcare','Nursing Care Facilities','Residential care for elderly or disabled patients');
call sp_insert_subindustry('Healthcare','Pharmaceutical Wholesale','Distributing medications to pharmacies');
call sp_insert_subindustry('Healthcare','Pharmaceuticals','Drug development and manufacturing');
call sp_insert_subindustry('Healthcare','Physical Therapy','Rehabilitation and treatment for injuries');
call sp_insert_subindustry('Healthcare','Radiology','Medical imaging and diagnostics');
call sp_insert_subindustry('Healthcare','Telehealth Services','Providing medical services remotely');
call sp_insert_subindustry('Hospitality and Leisure','Amusement Parks and Attractions','Theme parks and recreational facilities');
call sp_insert_subindustry('Hospitality and Leisure','Bed and Breakfasts','Accommodation with breakfast provided');
call sp_insert_subindustry('Hospitality and Leisure','Bed and Mattress Manufacturing','Producing beds and mattresses for hospitality');
call sp_insert_subindustry('Hospitality and Leisure','Camping and RV Parks','Outdoor camping and recreational vehicle parks');
call sp_insert_subindustry('Hospitality and Leisure','Casino Hotels','Hotels with attached casinos');
call sp_insert_subindustry('Hospitality and Leisure','Casinos','Gaming and entertainment venues');
call sp_insert_subindustry('Hospitality and Leisure','Cruise Lines','Operating cruise ships for leisure travel');
call sp_insert_subindustry('Hospitality and Leisure','Cruise Ship Services','Services offered onboard cruise ships');
call sp_insert_subindustry('Hospitality and Leisure','Entertainment Events','Organizing concerts, shows, and entertainment events');
call sp_insert_subindustry('Hospitality and Leisure','Event Management','Planning and organizing events and functions');
call sp_insert_subindustry('Hospitality and Leisure','Event Planning','Organizing and coordinating events');
call sp_insert_subindustry('Hospitality and Leisure','Gaming and Casinos','Gambling and casino entertainment');
call sp_insert_subindustry('Hospitality and Leisure','Golf Courses','Recreation and sports facilities for golfing');
call sp_insert_subindustry('Hospitality and Leisure','Hotel Management','Managing operations and services in hotels');
call sp_insert_subindustry('Hospitality and Leisure','Hotels and Resorts','Providing accommodation and hospitality services');
call sp_insert_subindustry('Hospitality and Leisure','Nightclubs and Bars','Entertainment venues for nightlife');
call sp_insert_subindustry('Hospitality and Leisure','Resort Management','Managing leisure resorts and vacation destinations');
call sp_insert_subindustry('Hospitality and Leisure','Restaurants and Bars','Food and beverage establishments');
call sp_insert_subindustry('Hospitality and Leisure','Spa and Wellness Centers','Providing relaxation and health treatments');
call sp_insert_subindustry('Hospitality and Leisure','Sports and Entertainment Venues','Arenas, stadiums, and event venues');
call sp_insert_subindustry('Hospitality and Leisure','Sports and Fitness Centers','Facilities for sports and fitness activities');
call sp_insert_subindustry('Hospitality and Leisure','Theme Parks','Amusement parks with themed attractions');
call sp_insert_subindustry('Hospitality and Leisure','Theme Restaurants','Restaurants with unique themes and experiences');
call sp_insert_subindustry('Hospitality and Leisure','Tour Operators','Organizing and conducting guided tours');
call sp_insert_subindustry('Hospitality and Leisure','Travel Agencies','Assisting travelers with trip planning');
call sp_insert_subindustry('Information Technology','Cloud Computing','Storing and accessing data over the internet');
call sp_insert_subindustry('Information Technology','Cybersecurity','Protecting systems and data from cyber threats');
call sp_insert_subindustry('Information Technology','Data Analytics','Analyzing and interpreting data for insights');
call sp_insert_subindustry('Information Technology','IT Consulting','Providing advice and solutions for IT projects');
call sp_insert_subindustry('Information Technology','Software as a Service (SaaS)','Offering software on a subscription basis');
call sp_insert_subindustry('Insurance','Auto Insurance','Insuring against damages and accidents');
call sp_insert_subindustry('Insurance','Aviation Insurance','Coverage for aviation risks and liabilities');
call sp_insert_subindustry('Insurance','Business Insurance','Insurance coverage for businesses');
call sp_insert_subindustry('Insurance','Business Interruption Insurance','Coverage for lost income due to business disruption');
call sp_insert_subindustry('Insurance','Captive Insurance','Self-insurance by a group of affiliated companies');
call sp_insert_subindustry('Insurance','Commercial Insurance','Insurance for businesses and commercial entities');
call sp_insert_subindustry('Insurance','Crop Insurance','Insurance for agricultural losses and risks');
call sp_insert_subindustry('Insurance','Cyber Insurance','Protecting against cyber-related risks');
call sp_insert_subindustry('Insurance','Cyber Liability Insurance','Protection against cyber-related risks');
call sp_insert_subindustry('Insurance','Health Insurance','Coverage for medical expenses and treatments');
call sp_insert_subindustry('Insurance','Health Reimbursement Arrangements (HRAs)','Employer-funded health expense reimbursements');
call sp_insert_subindustry('Insurance','Health Savings Accounts (HSAs)','Tax-advantaged accounts for medical expenses');
call sp_insert_subindustry('Insurance','Home Insurance','Insurance coverage for homeowners');
call sp_insert_subindustry('Insurance','Liability Insurance','Coverage for legal liabilities and lawsuits');
call sp_insert_subindustry('Insurance','Life Insurance','Offering protection against loss of life');
call sp_insert_subindustry('Insurance','Pet Insurance','Covering veterinary expenses for pets');
call sp_insert_subindustry('Insurance','Professional Liability Insurance','Protecting against professional errors and omissions');
call sp_insert_subindustry('Insurance','Property and Casualty Insurance','Protecting against property damage and liability');
call sp_insert_subindustry('Insurance','Reinsurance','Insurance for insurance companies');
call sp_insert_subindustry('Insurance','Title Insurance','Ensuring property ownership and title clarity');
call sp_insert_subindustry('Mining and Metals','Aluminum Production','Manufacturing aluminum and aluminum products');
call sp_insert_subindustry('Mining and Metals','Coal Mining','Extracting coal from the ground');
call sp_insert_subindustry('Mining and Metals','Copper Mining','Extracting copper from ore');
call sp_insert_subindustry('Mining and Metals','Diamond Mining','Extracting diamonds from mines');
call sp_insert_subindustry('Mining and Metals','Gold and Precious Metals','Mining and refining precious metals');
call sp_insert_subindustry('Mining and Metals','Iron and Steel','Producing iron and steel products');
call sp_insert_subindustry('Mining and Metals','Rare Earth Metals','Mining and processing rare earth elements');
call sp_insert_subindustry('Mining and Metals','Silver Mining','Extracting silver from ore');
call sp_insert_subindustry('Mining and Metals','Steel Manufacturing','Producing steel from iron ore');
call sp_insert_subindustry('Mining and Metals','Zinc Mining','Extracting zinc from ore');
call sp_insert_subindustry('Mining and Metals','','');
call sp_insert_subindustry('Pharmaceuticals','Biopharmaceuticals','Using living organisms for medical treatments');
call sp_insert_subindustry('Pharmaceuticals','Drug Distribution','Supplying medications to pharmacies');
call sp_insert_subindustry('Pharmaceuticals','Generic Drugs','Affordable alternatives to brand-name drugs');
call sp_insert_subindustry('Pharmaceuticals','Over-the-Counter (OTC) Drugs','Medications available without a prescription');
call sp_insert_subindustry('Pharmaceuticals','Vaccines','Immunizing against infectious diseases');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Antibody Therapeutics','Using antibodies as therapeutic agents');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Biomedical Research','Research on human health and diseases');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Biopharmaceutical Manufacturing','Producing drugs using biological processes');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Clinical Research','Conducting trials and studies for drug efficacy');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Contract Manufacturing','Outsourcing manufacturing for pharmaceuticals');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Contract Research Organizations (CROs)','Outsourcing research and development activities');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Diagnostic Equipment','Manufacturing medical devices for diagnosis');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Drug Discovery','Identifying and developing new medications');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Drug Discovery and Development','Researching and developing new medications');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Drug Manufacturing','Producing medications and pharmaceuticals');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Gene Therapy','Treating or preventing diseases with gene manipulation');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Genetic Engineering','Manipulating genes for medical purposes');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Medical Research','Conducting research on diseases and treatments');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Nanotechnology in Medicine','Applying nanoscale materials in medical treatments');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Personalized Medicine','Tailoring medical treatment to individuals');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Pharmaceutical Distribution','Supplying medications to pharmacies and hospitals');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Pharmaceutical Packaging','Packaging and labeling pharmaceutical products');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Pharmaceutical Testing','Conducting clinical trials for drugs and vaccines');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Pharmacogenomics','Studying the role of genetics in drug response');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Regenerative Medicine','Restoring damaged tissues and organs');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Regulatory Affairs','Ensuring compliance with pharmaceutical regulations');
call sp_insert_subindustry('Pharmaceuticals and Biotechnology','Vaccination Development','Developing vaccines for diseases');
call sp_insert_subindustry('Real Estate','Commercial Real Estate','Office buildings, retail spaces, etc.');
call sp_insert_subindustry('Real Estate','Property Management','Managing and maintaining properties');
call sp_insert_subindustry('Real Estate','Real Estate Development','Developing new real estate projects');
call sp_insert_subindustry('Real Estate','Real Estate Investment','Investing in properties for returns');
call sp_insert_subindustry('Real Estate','Residential Real Estate','Buying and selling homes and properties');
call sp_insert_subindustry('Retail','Apparel and Accessories Retail','Selling clothing, shoes, and accessories');
call sp_insert_subindustry('Retail','Convenience Stores','Small stores with extended hours and convenience');
call sp_insert_subindustry('Retail','Department Stores','Large retail stores with various product lines');
call sp_insert_subindustry('Retail','Electronics and Appliance Retail','Selling electronic devices and home appliances');
call sp_insert_subindustry('Retail','Food and Beverage Retail','Selling food products and beverages');
call sp_insert_subindustry('Retail','Luxury Retail','High-end products and personalized service');
call sp_insert_subindustry('Retail','Online Marketplaces','E-commerce platforms connecting buyers and sellers');
call sp_insert_subindustry('Retail','Online Retail','E-commerce platforms for selling products');
call sp_insert_subindustry('Retail','Specialty Stores','Focused on specific product categories');
call sp_insert_subindustry('Retail','Supermarkets','Large grocery stores');
call sp_insert_subindustry('Technology','Artificial Intelligence','Developing AI systems and applications');
call sp_insert_subindustry('Technology','E-commerce','Online buying and selling of goods and services');
call sp_insert_subindustry('Technology','Hardware Manufacturing','Production of computer hardware components');
call sp_insert_subindustry('Technology','Software Development','Creating and maintaining software applications');
call sp_insert_subindustry('Technology','Telecommunications','Network infrastructure and communication services');
call sp_insert_subindustry('Telecommunications','Internet Service Providers (ISPs)','Providing internet access to customers');
call sp_insert_subindustry('Telecommunications','Mobile Network Operators','Operating wireless communication networks');
call sp_insert_subindustry('Telecommunications','Satellite Communication','Transmitting signals via satellites');
call sp_insert_subindustry('Telecommunications','Telecommunication Equipment','Manufacturing communication devices');
call sp_insert_subindustry('Telecommunications','VoIP (Voice over Internet Protocol)','Making phone calls over the internet');
call sp_insert_subindustry('Textile','Apparel Manufacturing','Making clothing and accessories');
call sp_insert_subindustry('Textile','Carpet and Rug Manufacturing','Making carpets and rugs');
call sp_insert_subindustry('Textile','Clothing and Fabric Retail','Selling clothes and fabrics');
call sp_insert_subindustry('Textile','Textile Mills','Producing fabrics and textiles');
call sp_insert_subindustry('Textile','Textile Recycling','Reprocessing and reusing textile materials');
call sp_insert_subindustry('Tourism','Adventure Tourism','Exciting and unconventional travel experiences');
call sp_insert_subindustry('Tourism','Cruises','Vacation trips on cruise ships');
call sp_insert_subindustry('Tourism','Hotels','Providing accommodation for travelers');
call sp_insert_subindustry('Tourism','Tourist Attractions','Popular destinations for visitors');

-- create mysql table for tree of industry products or services
CREATE TABLE industry_products_services (
    id INT NOT NULL AUTO_INCREMENT,
    industry_id INT NOT NULL,
    product_or_service ENUM('product', 'service', 'other') NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    PRIMARY KEY (id),
    FOREIGN KEY (industry_id) REFERENCES industries(id),
    UNIQUE (name),
    INDEX (id)
);

-- create mysql table for roles in industries
CREATE TABLE industry_roles (
    id INT NOT NULL AUTO_INCREMENT,
    industry_id INT NOT NULL,
    role VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    PRIMARY KEY (id),
    FOREIGN KEY (industry_id) REFERENCES industries(id),
    UNIQUE (role),
    INDEX (id)
);

-- create mysql table for industry role's responsibilities
CREATE TABLE industry_role_responsibilities (
    id INT NOT NULL AUTO_INCREMENT,
    industry_role_id INT NOT NULL,
    responsibility TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    PRIMARY KEY (id),
    FOREIGN KEY (industry_role_id) REFERENCES industry_roles(id),
    INDEX (id)
);
