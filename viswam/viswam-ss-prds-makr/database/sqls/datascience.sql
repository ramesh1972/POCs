CREATE TABLE data_science_method_classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    parent_id INT DEFAULT null,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    FOREIGN KEY (parent_id) REFERENCES data_science_method_classes(id)
);

-- insert parent method classes
-- Model Inference
-- Data Transformation
-- Model Training and Data Transformation
-- Model Evaluation
-- Model Configuration
-- Model Information
-- Model Persistence
-- Model Compilation
-- Model Manipulation
-- Model Hooks
-- Model Visualization
-- Model Deployment
-- Model Serving
-- Model Monitoring
-- Model Interpretation
-- Model Explainability
-- Model Debugging
-- Model Optimization
-- Model Tuning
-- Model Selection
-- Model Comparison
-- Model Ensemble
-- Model Stacking
-- Model Pipelining
-- Model Hyperparameter Optimization
-- Model Regularization
-- Model Normalization
-- Model Scaling
-- Model Imputation
-- Model Encoding
-- Model Feature Selection
-- Model Feature Engineering
-- Model Feature Extraction
-- Model Feature Generation
-- Model Feature Transformation
-- Model Feature Scaling
-- Model Feature Normalization
-- Model Feature Imputation
-- Model Feature Encoding
-- Model Feature Selection
-- Model Feature Engineering
-- Model Feature Extraction
-- Model Feature Generation
-- Model Feature Transformation
-- Model Feature Scaling

-- insert the above mthods into the table with one songle query. please provide proper description fpor each method
INSERT INTO data_science_method_classes (name, description) VALUES
('Model Inference', 'Model Inference is the process of using a trained model to make predictions on new data.'),
('Data Transformation', 'Data Transformation is the process of converting raw data into a format that is suitable for analysis.'),
('Model Training and Data Transformation', 'Model Training and Data Transformation is the process of training a model on a dataset and transforming the data to be used for training.'),
('Model Evaluation', 'Model Evaluation is the process of assessing the performance of a trained model on a dataset.'),
('Model Configuration', 'Model Configuration is the process of setting the hyperparameters of a model.'),
('Model Information', 'Model Information is the process of obtaining information about a trained model.'),
('Model Persistence', 'Model Persistence is the process of saving a trained model to disk.'),
('Model Compilation', 'Model Compilation is the process of converting a high-level model description into a low-level representation that can be executed on a specific hardware platform.'),
('Model Manipulation', 'Model Manipulation is the process of modifying a trained model.'),
('Model Hooks', 'Model Hooks are functions that are called at specific points during the training or evaluation of a model.'),
('Model Visualization', 'Model Visualization is the process of creating visualizations of a trained model.'),
('Model Deployment', 'Model Deployment is the process of making a trained model available for use in a production environment.'),
('Model Serving', 'Model Serving is the process of serving predictions from a trained model.'),
('Model Monitoring', 'Model Monitoring is the process of monitoring the performance of a trained model in a production environment.'),
('Model Interpretation', 'Model Interpretation is the process of interpreting the predictions of a trained model.'),
('Model Explainability', 'Model Explainability is the process of explaining how a trained model arrived at a particular prediction.'),
('Model Debugging', 'Model Debugging is the process of identifying and fixing errors in a trained model.'),
('Model Optimization', 'Model Optimization is the process of improving the performance of a trained model.'),
('Model Tuning', 'Model Tuning is the process of adjusting the hyperparameters of a trained model to improve its performance.'),
('Model Selection', 'Model Selection is the process of choosing the best model from a set of candidate models.'),
('Model Comparison', 'Model Comparison is the process of comparing the performance of different models on a dataset.'),
('Model Ensemble', 'Model Ensemble is the process of combining the predictions of multiple models to improve performance.'),
('Model Stacking', 'Model Stacking is the process of combining the predictions of multiple models using a meta-model.'),
('Model Pipelining', 'Model Pipelining is the process of chaining together multiple data processing steps and a model into a single pipeline.'),
('Model Hyperparameter Optimization', 'Model Hyperparameter Optimization is the process of finding the best hyperparameters for a model.'),
('Model Regularization', 'Model Regularization is the process of adding a penalty term to the loss function to prevent overfitting.'),
('Model Normalization', 'Model Normalization is the process of scaling the input features to have zero mean and unit variance.'),
('Model Scaling', 'Model Scaling is the process of scaling the input features to a specified range.'),
('Model Imputation', 'Model Imputation is the process of filling in missing values in a dataset.'),
('Model Encoding', 'Model Encoding is the process of converting categorical variables into a numerical representation.'),
('Model Feature Selection', 'Model Feature Selection is the process of selecting a subset of input features to use in a model.'),
('Model Feature Engineering', 'Model Feature Engineering is the process of creating new input features from existing features.'),
('Model Feature Extraction', 'Model Feature Extraction is the process of extracting features from raw data.'),
('Model Feature Generation', 'Model Feature Generation is the process of generating new features from existing features.'),
('Model Feature Transformation', 'Model Feature Transformation is the process of transforming input features into a new representation.'),
('Model Feature Scaling', 'Model Feature Scaling is the process of scaling input features to a specified range.'),
('Model Feature Normalization', 'Model Feature Normalization is the process of scaling input features to have zero mean and unit variance.'),
('Model Feature Imputation', 'Model Feature Imputation is the process of filling in missing values in input features.'),
('Model Feature Encoding', 'Model Feature Encoding is the process of converting categorical input features into a numerical representation.'),
('Model Feature Selection', 'Model Feature Selection is the process of selecting a subset of input features to use in a model.'),
('Model Feature Engineering', 'Model Feature Engineering is the process of creating new input features from existing features.'),
('Model Feature Extraction', 'Model Feature Extraction is the process of extracting features from raw data.'),
('Model Feature Generation', 'Model Feature Generation is the process of generating new features from existing features.'),
('Model Feature Transformation', 'Model Feature Transformation is the process of transforming input features into a new representation.'),
('Model Feature Scaling', 'Model Feature Scaling is the process of scaling input features to a specified range.');

-- create a SP to insert child methods
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_data_science_sub_method_class`(IN `method_class_name` VARCHAR(255), IN `parent_method_class_name` VARCHAR(255), IN `description` TEXT)
BEGIN
    DECLARE parent_method_class_id INT;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
    SELECT 
        id INTO parent_method_class_id 
    FROM
        data_science_method_classes
    WHERE
        name = parent_method_class_name;

    IF parent_method_class_id IS NOT NULL THEN
        INSERT INTO data_science_method_classes (name, description, parent_id) VALUES (method_class_name, description, parent_method_class_id);
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END$$
DELIMITER ;

-- insert submethod classes, provide proper description for each method
call sp_insert_data_science_sub_method_class('Training','Model Training','Model Training');
call sp_insert_data_science_sub_method_class('Prediction','Model Inference','Model Inference');
call sp_insert_data_science_sub_method_class('Transformation','Data Transformation','Data Transformation');
call sp_insert_data_science_sub_method_class('Training and Transformation','Model Training and Data Transformation','Model Training and Data Transformation');
call sp_insert_data_science_sub_method_class('Evaluation','Model Evaluation','Model Evaluation');
call sp_insert_data_science_sub_method_class('Incremental Training','Model Training','Model Training');
call sp_insert_data_science_sub_method_class('Probability Prediction','Model Inference','Model Inference');
call sp_insert_data_science_sub_method_class('Decision Function','Model Inference','Model Inference');
call sp_insert_data_science_sub_method_class('Inverse Transformation','Data Transformation','Data Transformation');
call sp_insert_data_science_sub_method_class('Configuration','Model Configuration','Model Configuration');
call sp_insert_data_science_sub_method_class('Configuration','Model Configuration','Model Configuration');
call sp_insert_data_science_sub_method_class('Iteration Information','Model Training','Model Training');
call sp_insert_data_science_sub_method_class('Model Coefficients','Model Information','Model Information');
call sp_insert_data_science_sub_method_class('Feature Importances','Model Information','Model Information');
call sp_insert_data_science_sub_method_class('Model Saving','Model Persistence','Model Persistence');
call sp_insert_data_science_sub_method_class('Model Loading','Model Persistence','Model Persistence');
call sp_insert_data_science_sub_method_class('Compilation','Model Compilation','Model Compilation');
call sp_insert_data_science_sub_method_class('Evaluation','Model Evaluation','Model Evaluation');
call sp_insert_data_science_sub_method_class('Generator Training','Model Training','Model Training');
call sp_insert_data_science_sub_method_class('Model Summary','Model Information','Model Information');
call sp_insert_data_science_sub_method_class('Cloning','Model Manipulation','Model Manipulation');
call sp_insert_data_science_sub_method_class('Cross-validation','Model Evaluation','Model Evaluation');
call sp_insert_data_science_sub_method_class('Partial Prediction','Model Inference','Model Inference');
call sp_insert_data_science_sub_method_class('Warm Start','Model Training','Model Training');
call sp_insert_data_science_sub_method_class('Staged Prediction','Model Inference','Model Inference');
call sp_insert_data_science_sub_method_class('Model Validation','Model Evaluation','Model Evaluation');
call sp_insert_data_science_sub_method_class('Log Probability Prediction','Model Inference','Model Inference');
call sp_insert_data_science_sub_method_class('Class Prediction','Model Inference','Model Inference');
call sp_insert_data_science_sub_method_class('Batch Training','Model Training','Model Training');
call sp_insert_data_science_sub_method_class('State Reset','Model Manipulation','Model Manipulation');
call sp_insert_data_science_sub_method_class('Model Application','Model Manipulation','Model Manipulation');
call sp_insert_data_science_sub_method_class('Model Weights','Model Information','Model Information');
call sp_insert_data_science_sub_method_class('Model Weights','Model Manipulation','Model Manipulation');
call sp_insert_data_science_sub_method_class('Layer Retrieval','Model Information','Model Information');
call sp_insert_data_science_sub_method_class('Model Layer Removal','Model Manipulation','Model Manipulation');
call sp_insert_data_science_sub_method_class('Model Layer Addition','Model Manipulation','Model Manipulation');
call sp_insert_data_science_sub_method_class('Model Serialization','Model Persistence','Model Persistence');
call sp_insert_data_science_sub_method_class('Model Deserialization','Model Persistence','Model Persistence');
call sp_insert_data_science_sub_method_class('Model Configuration','Model Configuration','Model Configuration');
call sp_insert_data_science_sub_method_class('Model Configuration','Model Configuration','Model Configuration');
call sp_insert_data_science_sub_method_class('Hook Registration','Model Hooks','Model Hooks');
call sp_insert_data_science_sub_method_class('Hook Registration','Model Hooks','Model Hooks');

-- create table datascience_algo_classes
CREATE TABLE data_science_model_classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    parent_id INT DEFAULT null,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    FOREIGN KEY (parent_id) REFERENCES data_science_model_classes(id)
);

-- insert the following values in the table
-- Anomaly Detection
-- Approximate Algorithms
-- Association Rule Learning
-- Clustering Algorithms
-- Computer Vision
-- Decision Trees
-- Dimensionality Reduction
-- Dynamic Programming
-- Ensemble Methods
-- Graphical Models
-- Hyperparameter Tuning
-- Natural Language Processing
-- Neural Networks
-- NLP
-- Optimization
-- Optimization Algorithms
-- Probabilistic Models
-- Recommender Systems
-- Regression Algorithms
-- Reinforcement Learning
-- Rule-based Algorithms
-- Search and Optimization
-- Sequential Data
-- Sequential Models
-- Signal Processing
-- Similarity Measures
-- Simulation Methods
-- Specialized Algorithms
-- Statistical Algorithms
-- Statistical Methods
-- Supervised Learning
-- Text Similarity
-- Time Series
-- Time-Series Algorithms
-- Unsupervised Learning
-- Collaborative Filtering
-- Time Series Analysis
-- Generative Modeling
-- Sequence Modeling
-- Ensemble Learning
-- Graph-based Learning
-- Speech Processing
-- Markov Models
-- Clustering
-- Regression
-- Evolutionary Algorithms
INSERT INTO data_science_model_classes (name, description) Values
('Anomaly Detection', 'Anomaly Detection is the process of identifying patterns in data that do not conform to expected behavior.'),
('Approximate Algorithms', 'Approximate Algorithms are algorithms that provide approximate solutions to computational problems.'),
('Association Rule Learning', 'Association Rule Learning is the process of discovering interesting relationships between variables in large datasets.'),
('Clustering Algorithms', 'Clustering Algorithms are algorithms that group similar data points together.'),
('Computer Vision', 'Computer Vision is the field of study that focuses on enabling computers to interpret and understand visual information.'),
('Decision Trees', 'Decision Trees are a type of supervised learning algorithm that is used for classification and regression tasks.'),
('Dimensionality Reduction', 'Dimensionality Reduction is the process of reducing the number of input variables in a dataset.'),
('Dynamic Programming', 'Dynamic Programming is a method for solving complex problems by breaking them down into simpler subproblems.'),
('Ensemble Methods', 'Ensemble Methods are machine learning techniques that combine the predictions of multiple models to improve performance.'),
('Graphical Models', 'Graphical Models are a class of probabilistic models that represent the dependencies between random variables using a graph.'),
('Hyperparameter Tuning', 'Hyperparameter Tuning is the process of selecting the best hyperparameters for a machine learning model.'),
('Natural Language Processing', 'Natural Language Processing is the field of study that focuses on enabling computers to understand and generate human language.'),
('Neural Networks', 'Neural Networks are a class of machine learning models that are inspired by the structure and function of the human brain.'),
('NLP', 'NLP is an abbreviation for Natural Language Processing.'),
('Optimization', 'Optimization is the process of finding the best solution to a problem.'),
('Probabilistic Models', 'Probabilistic Models are models that represent uncertainty using probability distributions.'),
('Recommender Systems', 'Recommender Systems are systems that recommend items to users based on their preferences and behavior.'),
('Regression Algorithms', 'Regression Algorithms are algorithms that are used to predict a continuous value.'),
('Reinforcement Learning', 'Reinforcement Learning is a type of machine learning that is based on the idea of learning by interacting with an environment.'),
('Rule-based Algorithms', 'Rule-based Algorithms are algorithms that use a set of rules to make decisions.'),
('Search and Optimization', 'Search and Optimization are techniques for finding the best solution to a problem.'),
('Sequential Data', 'Sequential Data is data that is ordered in a sequence.'),
('Sequential Models', 'Sequential Models are models that are designed to work with sequential data.'),
('Signal Processing', 'Signal Processing is the process of analyzing and manipulating signals.'),
('Similarity Measures', 'Similarity Measures are measures that quantify the similarity between two objects.'),
('Simulation Methods', 'Simulation Methods are methods for simulating complex systems.'),
('Specialized Algorithms', 'Specialized Algorithms are algorithms that are designed for specific tasks.'),
('Statistical Algorithms', 'Statistical Algorithms are algorithms that are based on statistical principles.'),
('Statistical Methods', 'Statistical Methods are methods that are based on statistical principles.'),
('Supervised Learning', 'Supervised Learning is a type of machine learning where the model is trained on labeled data.'),
('Text Similarity', 'Text Similarity is the process of quantifying the similarity between two pieces of text.'),
('Time Series', 'Time Series is a sequence of data points that are ordered in time.'),
('Time-Series Algorithms', 'Time-Series Algorithms are algorithms that are designed to work with time-series data.'),
('Unsupervised Learning', 'Unsupervised Learning is a type of machine learning where the model is trained on unlabeled data.'),
('Collaborative Filtering', 'Collaborative Filtering is a method for making automatic predictions about the interests of a user by collecting preferences from many users.'),
('Time Series Analysis', 'Time Series Analysis is the process of analyzing time-series data to extract meaningful insights.'),
('Generative Modeling', 'Generative Modeling is the process of learning a probability distribution over the input data.'),
('Sequence Modeling', 'Sequence Modeling is the process of modeling sequences of data.'),
('Ensemble Learning', 'Ensemble Learning is the process of combining the predictions of multiple models to improve performance.'),
('Graph-based Learning', 'Graph-based Learning is the process of learning from data that is represented as a graph.'),
('Speech Processing', 'Speech Processing is the process of analyzing and synthesizing speech signals.'),
('Markov Models', 'Markov Models are models that assume that the future state of a system depends only on the current state.'),
('Clustering', 'Clustering is the process of grouping similar data points together.'),
('Regression', 'Regression is the process of predicting a continuous value.'),
('Evolutionary Algorithms', 'Evolutionary Algorithms are algorithms that are inspired by the process of natural selection.');

-- create table datascience_functional_classes
CREATE TABLE data_science_functional_classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    parent_id INT DEFAULT null,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    FOREIGN KEY (parent_id) REFERENCES data_science_functional_classes(id)
);
 
-- insert the following values in the table
-- Computer Vision
-- Natural Language Processing
-- Finance
-- Robotics
-- Conversational AI
-- Predictive Maintenance
-- Healthcare
-- Recommendation Systems
-- Sports Analytics
-- Energy Management
-- Virtual Reality
-- Speech Recognition
-- Text Summarization
-- Human Resources
-- Environmental Science
-- Agriculture
-- Content Creation
-- Social Media Analysis
-- Transportation
-- Gaming
-- E-commerce
-- Marketing
-- Security
-- Text Analysis
-- Customer Retention
-- Document Classification
-- Environmental Monitoring
-- Customer Support
-- Speech Synthesis
-- Market Analysis
-- Education
-- Emotion Analysis
-- Media
-- Geology
-- Law Enforcement
-- Meteorology
-- Customer Lifetime Value
-- Supply Chain Management
-- Manufacturing
-- Text Generation
-- Home Automation
-- Job Matching
-- Advertising
-- Music Composition
-- Development
-- Politics
-- Augmented Reality
-- Travel
-- Text Input
-- Accessibility
-- Maritime
-- Emergency Response
-- Retail
-- Crowdsourcing
-- Email Management
-- Product Development
-- Audio
-- Insurance
-- Parental Monitoring
-- Navigation
-- Analytics

INSERT INTO data_science_functional_classes (name, description) VALUES
('Computer Vision', 'Computer Vision is the field of study that focuses on enabling computers to interpret and understand visual information.'),
('Natural Language Processing', 'Natural Language Processing is the field of study that focuses on enabling computers to understand and generate human language.'),
('Finance', 'Finance is the field of study that focuses on the management of money and investments.'),
('Robotics', 'Robotics is the field of study that focuses on the design and construction of robots.'),
('Conversational AI', 'Conversational AI is the field of study that focuses on creating AI systems that can engage in natural language conversations with humans.'),
('Predictive Maintenance', 'Predictive Maintenance is the process of using data to predict when equipment is likely to fail so that maintenance can be performed proactively.'),
('Healthcare', 'Healthcare is the field of study that focuses on the maintenance or improvement of health.'),
('Recommendation Systems', 'Recommendation Systems are systems that recommend items to users based on their preferences and behavior.'),
('Sports Analytics', 'Sports Analytics is the field of study that focuses on using data to gain insights into sports performance.'),
('Energy Management', 'Energy Management is the process of monitoring, controlling, and conserving energy in a building or organization.'),
('Virtual Reality', 'Virtual Reality is a simulated experience that can be similar to or completely different from the real world.'),
('Speech Recognition', 'Speech Recognition is the process of converting spoken words into text.'),
('Text Summarization', 'Text Summarization is the process of creating a concise summary of a longer text.'),
('Human Resources', 'Human Resources is the department of a company that is responsible for managing employee relations.'),
('Environmental Science', 'Environmental Science is the field of study that focuses on the environment and its interactions with living organisms.'),
('Agriculture', 'Agriculture is the practice of cultivating plants and livestock for food, fiber, and other products.'),
('Content Creation', 'Content Creation is the process of generating ideas and creating content for various media.'),
('Social Media Analysis', 'Social Media Analysis is the process of analyzing social media data to gain insights into user behavior.'),
('Transportation', 'Transportation is the movement of people, animals, and goods from one place to another.'),
('Gaming', 'Gaming is the playing of electronic games.'),
('E-commerce', 'E-commerce is the buying and selling of goods and services over the internet.'),
('Marketing', 'Marketing is the process of promoting and selling products or services.'),
('Security', 'Security is the state of being free from danger or threat.'),
('Text Analysis', 'Text Analysis is the process of analyzing and extracting information from text data.'),
('Customer Retention', 'Customer Retention is the process of keeping customers engaged and satisfied with a product or service.'),
('Document Classification', 'Document Classification is the process of categorizing documents into predefined classes.'),
('Environmental Monitoring', 'Environmental Monitoring is the process of monitoring the environment for changes.'),
('Customer Support', 'Customer Support is the process of providing assistance to customers.'),
('Speech Synthesis', 'Speech Synthesis is the process of generating human-like speech from text.'),
('Market Analysis', 'Market Analysis is the process of analyzing market data to gain insights into market trends.'),
('Education', 'Education is the process of acquiring knowledge and skills.'),
('Emotion Analysis', 'Emotion Analysis is the process of detecting and analyzing emotions in text or speech.'),
('Media', 'Media is the means of communication that reach or influence people widely.'),
('Geology', 'Geology is the study of the Earths structure, composition, and history.'),
('Law Enforcement', 'Law Enforcement is the system by which some members of society act in an organized manner to enforce the law by discovering, deterring, rehabilitating, or punishing people who violate the rules and norms governing that society.'),
('Meteorology', 'Meteorology is the study of the Earths atmosphere and weather.'),
('Customer Lifetime Value', 'Customer Lifetime Value is the predicted net profit attributed to the entire future relationship with a customer.'),
('Supply Chain Management', 'Supply Chain Management is the management of the flow of goods and services from the point of origin to the point of consumption.'),
('Manufacturing', 'Manufacturing is the production of goods using labor, machines, tools, and chemical or biological processing or formulation.'),
('Text Generation', 'Text Generation is the process of generating text using machine learning models.'),
('Home Automation', 'Home Automation is the process of automating the control of home appliances and devices.'),
('Job Matching', 'Job Matching is the process of matching job seekers with job openings.'),
('Advertising', 'Advertising is the process of promoting a product or service through paid channels.'),
('Music Composition', 'Music Composition is the process of creating music.'),
('Development', 'Development is the process of growing or improving something.'),
('Politics', 'Politics is the activities associated with the governance of a country or area.'),
('Augmented Reality', 'Augmented Reality is an interactive experience of a real-world environment where the objects that reside in the real world are enhanced by computer-generated perceptual information.'),
('Travel', 'Travel is the movement of people between distant geographical locations.'),
('Text Input', 'Text Input is the process of entering text into a computer or other device.'),
('Accessibility', 'Accessibility is the design of products, devices, services, or environments for people with disabilities.'),
('Maritime', 'Maritime is related to the sea or navigation.'),
('Emergency Response', 'Emergency Response is the process of responding to emergencies.'),
('Retail', 'Retail is the sale of goods to the public for use or consumption rather than for resale.'),
('Crowdsourcing', 'Crowdsourcing is the practice of obtaining input into a task or project by enlisting the services of a large number of people.'),
('Email Management', 'Email Management is the process of managing email communications.'),
('Product Development', 'Product Development is the process of designing, creating, and marketing new products.'),
('Audio', 'Audio is sound within the acoustic range available to humans.'),
('Insurance', 'Insurance is a contract that provides financial protection or reimbursement against losses.'),
('Parental Monitoring', 'Parental Monitoring is the process of monitoring and supervising childrens activities.'),
('Navigation', 'Navigation is the process of planning and controlling the movement of a vehicle or vessel.'),
('Analytics', 'Analytics is the discovery, interpretation, and communication of meaningful patterns in data.');

-- create sp tp insert functional classes
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_data_science_functional_class`(IN `func_class_name` VARCHAR(255), IN `parent_func_class_name` VARCHAR(255), IN `description` TEXT)
BEGIN
    DECLARE parent_func_class_id INT DEFAULT null;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
    IF parent_func_class_name = '' THEN
        INSERT INTO data_science_functional_classes (name, description) VALUES (func_class_name, description);
    ELSE
        SELECT 
            id INTO parent_func_class_id 
        FROM
            data_science_functional_classes
        WHERE
            name = parent_func_class_name;

        INSERT INTO data_science_functional_classes (name, description, parent_id) VALUES (func_class_name, description, parent_func_class_id);
    END IF;
    COMMIT;
END$$
DELIMITER ;

-- insert values
call sp_insert_data_science_functional_class('Classification','Computer Vision','');
call sp_insert_data_science_functional_class('Text Classification','Natural Language Processing','');
call sp_insert_data_science_functional_class('Anomaly Detection','Finance','');
call sp_insert_data_science_functional_class('Object Detection','Robotics','');
call sp_insert_data_science_functional_class('Natural Language Processing','Conversational AI','');
call sp_insert_data_science_functional_class('Predictive Analytics','Predictive Maintenance','');
call sp_insert_data_science_functional_class('Drug Discovery','Healthcare','');
call sp_insert_data_science_functional_class('Recommendation Systems','Recommendation Systems','');
call sp_insert_data_science_functional_class('Object Detection','Computer Vision','');
call sp_insert_data_science_functional_class('Time Series Analysis','Finance','');
call sp_insert_data_science_functional_class('Machine Translation','Natural Language Processing','');
call sp_insert_data_science_functional_class('Analytics','Sports Analytics','');
call sp_insert_data_science_functional_class('Energy Management','Energy Management','');
call sp_insert_data_science_functional_class('Virtual Reality','Virtual Reality','');
call sp_insert_data_science_functional_class('Speech Recognition','Speech Recognition','');
call sp_insert_data_science_functional_class('Natural Language Processing','Text Summarization','');
call sp_insert_data_science_functional_class('HR Analytics','Human Resources','');
call sp_insert_data_science_functional_class('Diagnosis','Healthcare','');
call sp_insert_data_science_functional_class('Predictive Modeling','Environmental Science','');
call sp_insert_data_science_functional_class('Precision Agriculture','Agriculture','');
call sp_insert_data_science_functional_class('Machine Translation','Natural Language Processing','');
call sp_insert_data_science_functional_class('Generation','Content Creation','');
call sp_insert_data_science_functional_class('Network Analysis','Social Media Analysis','');
call sp_insert_data_science_functional_class('Object Detection','Computer Vision','');
call sp_insert_data_science_functional_class('Time Series Analysis','Transportation','');
call sp_insert_data_science_functional_class('Game Development','Gaming','');
call sp_insert_data_science_functional_class('Price Optimization','E-commerce','');
call sp_insert_data_science_functional_class('Object Detection','Computer Vision','');
call sp_insert_data_science_functional_class('Conversational AI','Conversational AI','');
call sp_insert_data_science_functional_class('Credit Scoring','Finance','');
call sp_insert_data_science_functional_class('Segmentation','Marketing','');
call sp_insert_data_science_functional_class('Anomaly Detection','Security','');
call sp_insert_data_science_functional_class('Speech Recognition','Speech Recognition','');
call sp_insert_data_science_functional_class('Text Analysis','Text Analysis','');
call sp_insert_data_science_functional_class('Predictive Analytics','Customer Retention','');
call sp_insert_data_science_functional_class('HR Analytics','Human Resources','');
call sp_insert_data_science_functional_class('Recommendation Systems','Recommendation Systems','');
call sp_insert_data_science_functional_class('Object Detection','Computer Vision','');
call sp_insert_data_science_functional_class('Authentication','Security','');
call sp_insert_data_science_functional_class('Optimization','Transportation','');
call sp_insert_data_science_functional_class('Classification','Document Classification','');
call sp_insert_data_science_functional_class('Object Detection','Environmental Monitoring','');
call sp_insert_data_science_functional_class('Customer Support','Customer Support','');
call sp_insert_data_science_functional_class('Speech Synthesis','Speech Synthesis','');
call sp_insert_data_science_functional_class('Classification','Natural Language Processing','');
call sp_insert_data_science_functional_class('Market Analysis','Market Analysis','');
call sp_insert_data_science_functional_class('Classification','Natural Language Processing','');
call sp_insert_data_science_functional_class('Object Detection','Robotics','');
call sp_insert_data_science_functional_class('Monitoring','Healthcare','');
call sp_insert_data_science_functional_class('Tutoring','Education','');
call sp_insert_data_science_functional_class('Energy Management','Energy Management','');
call sp_insert_data_science_functional_class('Emotion Analysis','Emotion Analysis','');
call sp_insert_data_science_functional_class('Predictive Modeling','Healthcare','');
call sp_insert_data_science_functional_class('Natural Language Generation','Media','');
call sp_insert_data_science_functional_class('Machine Learning','Education','');
call sp_insert_data_science_functional_class('Predictive Modeling','Geology','');
call sp_insert_data_science_functional_class('Monitoring','Social Media Analysis','');
call sp_insert_data_science_functional_class('Object Tracking','Computer Vision','');
call sp_insert_data_science_functional_class('Predictive Analytics','Law Enforcement','');
call sp_insert_data_science_functional_class('Object Detection','Agriculture','');
call sp_insert_data_science_functional_class('Predictive Modeling','Meteorology','');
call sp_insert_data_science_functional_class('Predictive Analytics','Customer Lifetime Value','');
call sp_insert_data_science_functional_class('Optimization','Supply Chain Management','');
call sp_insert_data_science_functional_class('Machine Translation','Natural Language Processing','');
call sp_insert_data_science_functional_class('Quality Control','Manufacturing','');
call sp_insert_data_science_functional_class('Recommendation Systems','Recommendation Systems','');
call sp_insert_data_science_functional_class('Generation','Text Generation','');
call sp_insert_data_science_functional_class('Navigation','Robotics','');
call sp_insert_data_science_functional_class('Talent Management','Human Resources','');
call sp_insert_data_science_functional_class('Home Automation','Home Automation','');
call sp_insert_data_science_functional_class('Predictive Modeling','Agriculture','');
call sp_insert_data_science_functional_class('Matching','Job Matching','');
call sp_insert_data_science_functional_class('Telemedicine','Healthcare','');
call sp_insert_data_science_functional_class('Advertisement','Advertising','');
call sp_insert_data_science_functional_class('Music Composition','Music Composition','');
call sp_insert_data_science_functional_class('Code Review','Development','');
call sp_insert_data_science_functional_class('Predictive Analytics','Politics','');
call sp_insert_data_science_functional_class('Quality Control','Manufacturing','');
call sp_insert_data_science_functional_class('Emotion Analysis','Emotion Analysis','');
call sp_insert_data_science_functional_class('Billing','Finance','');
call sp_insert_data_science_functional_class('Augmented Reality','Augmented Reality','');
call sp_insert_data_science_functional_class('Anomaly Detection','Security','');
call sp_insert_data_science_functional_class('Planning','Travel','');
call sp_insert_data_science_functional_class('Monitoring','Environmental Monitoring','');
call sp_insert_data_science_functional_class('Predictive Modeling','Healthcare','');
call sp_insert_data_science_functional_class('Scoring','Education','');
call sp_insert_data_science_functional_class('Optimization','Transportation','');
call sp_insert_data_science_functional_class('Auctions','E-commerce','');
call sp_insert_data_science_functional_class('Strategy','Gaming','');
call sp_insert_data_science_functional_class('Path Planning','Robotics','');
call sp_insert_data_science_functional_class('Training','Robotics','');
call sp_insert_data_science_functional_class('Predictive Analytics','Text Input','');
call sp_insert_data_science_functional_class('Assistance','Accessibility','');
call sp_insert_data_science_functional_class('Object Detection','Maritime','');
call sp_insert_data_science_functional_class('Predictive Analytics','Education','');
call sp_insert_data_science_functional_class('Summarization','Education','');
call sp_insert_data_science_functional_class('Optimization','Emergency Response','');
call sp_insert_data_science_functional_class('Restocking','Retail','');
call sp_insert_data_science_functional_class('Analysis','Crowdsourcing','');
call sp_insert_data_science_functional_class('Aggregation','Media','');
call sp_insert_data_science_functional_class('Categorization','Email Management','');
call sp_insert_data_science_functional_class('Predictive Modeling','Environmental Science','');
call sp_insert_data_science_functional_class('Product Development','Product Development','');
call sp_insert_data_science_functional_class('Tutoring','Education','');
call sp_insert_data_science_functional_class('Financial Management','Finance','');
call sp_insert_data_science_functional_class('Asset Management','Finance','');
call sp_insert_data_science_functional_class('Virtual Fitting','E-commerce','');
call sp_insert_data_science_functional_class('Audio Mastering','Audio','');
call sp_insert_data_science_functional_class('Emotion Analysis','Emotion Analysis','');
call sp_insert_data_science_functional_class('Fraud Detection','Insurance','');
call sp_insert_data_science_functional_class('Optimization','Energy Management','');
call sp_insert_data_science_functional_class('Monitoring','Parental Monitoring','');
call sp_insert_data_science_functional_class('Positioning','Navigation','');
call sp_insert_data_science_functional_class('Sports Analysis','Sports Analytics','');
call sp_insert_data_science_functional_class('Computer Vision',null,'');
call sp_insert_data_science_functional_class('Natural Language Processing',null,'');
call sp_insert_data_science_functional_class('Finance',null,'');
call sp_insert_data_science_functional_class('Robotics',null,'');
call sp_insert_data_science_functional_class('Conversational AI',null,'');
call sp_insert_data_science_functional_class('Predictive Maintenance',null,'');
call sp_insert_data_science_functional_class('Healthcare',null,'');
call sp_insert_data_science_functional_class('Recommendation Systems',null,'');
call sp_insert_data_science_functional_class('Computer Vision',null,'');
call sp_insert_data_science_functional_class('Finance',null,'');
call sp_insert_data_science_functional_class('Natural Language Processing',null,'');
call sp_insert_data_science_functional_class('Sports Analytics',null,'');
call sp_insert_data_science_functional_class('Energy Management',null,'');
call sp_insert_data_science_functional_class('Virtual Reality',null,'');
call sp_insert_data_science_functional_class('Speech Recognition',null,'');
call sp_insert_data_science_functional_class('Text Summarization',null,'');
call sp_insert_data_science_functional_class('Human Resources',null,'');
call sp_insert_data_science_functional_class('Healthcare',null,'');
call sp_insert_data_science_functional_class('Environmental Science',null,'');
call sp_insert_data_science_functional_class('Agriculture',null,'');
call sp_insert_data_science_functional_class('Natural Language Processing',null,'');
call sp_insert_data_science_functional_class('Content Creation',null,'');
call sp_insert_data_science_functional_class('Social Media Analysis',null,'');
call sp_insert_data_science_functional_class('Computer Vision',null,'');
call sp_insert_data_science_functional_class('Transportation',null,'');
call sp_insert_data_science_functional_class('Gaming',null,'');
call sp_insert_data_science_functional_class('E-commerce',null,'');
call sp_insert_data_science_functional_class('Computer Vision',null,'');
call sp_insert_data_science_functional_class('Conversational AI',null,'');
call sp_insert_data_science_functional_class('Finance',null,'');
call sp_insert_data_science_functional_class('Marketing',null,'');
call sp_insert_data_science_functional_class('Security',null,'');
call sp_insert_data_science_functional_class('Speech Recognition',null,'');
call sp_insert_data_science_functional_class('Text Analysis',null,'');
call sp_insert_data_science_functional_class('Customer Retention',null,'');
call sp_insert_data_science_functional_class('Human Resources',null,'');
call sp_insert_data_science_functional_class('Recommendation Systems',null,'');
call sp_insert_data_science_functional_class('Computer Vision',null,'');
call sp_insert_data_science_functional_class('Security',null,'');
call sp_insert_data_science_functional_class('Transportation',null,'');
call sp_insert_data_science_functional_class('Document Classification',null,'');
call sp_insert_data_science_functional_class('Environmental Monitoring',null,'');
call sp_insert_data_science_functional_class('Customer Support',null,'');
call sp_insert_data_science_functional_class('Speech Synthesis',null,'');
call sp_insert_data_science_functional_class('Natural Language Processing',null,'');
call sp_insert_data_science_functional_class('Market Analysis',null,'');
call sp_insert_data_science_functional_class('Natural Language Processing',null,'');
call sp_insert_data_science_functional_class('Robotics',null,'');
call sp_insert_data_science_functional_class('Healthcare',null,'');
call sp_insert_data_science_functional_class('Education',null,'');
call sp_insert_data_science_functional_class('Energy Management',null,'');
call sp_insert_data_science_functional_class('Emotion Analysis',null,'');
call sp_insert_data_science_functional_class('Healthcare',null,'');
call sp_insert_data_science_functional_class('Media',null,'');
call sp_insert_data_science_functional_class('Education',null,'');
call sp_insert_data_science_functional_class('Geology',null,'');
call sp_insert_data_science_functional_class('Social Media Analysis',null,'');
call sp_insert_data_science_functional_class('Computer Vision',null,'');
call sp_insert_data_science_functional_class('Law Enforcement',null,'');
call sp_insert_data_science_functional_class('Agriculture',null,'');
call sp_insert_data_science_functional_class('Meteorology',null,'');
call sp_insert_data_science_functional_class('Customer Lifetime Value',null,'');
call sp_insert_data_science_functional_class('Supply Chain Management',null,'');
call sp_insert_data_science_functional_class('Natural Language Processing',null,'');
call sp_insert_data_science_functional_class('Manufacturing',null,'');
call sp_insert_data_science_functional_class('Recommendation Systems',null,'');
call sp_insert_data_science_functional_class('Text Generation',null,'');
call sp_insert_data_science_functional_class('Robotics',null,'');
call sp_insert_data_science_functional_class('Human Resources',null,'');
call sp_insert_data_science_functional_class('Home Automation',null,'');
call sp_insert_data_science_functional_class('Agriculture',null,'');
call sp_insert_data_science_functional_class('Job Matching',null,'');
call sp_insert_data_science_functional_class('Healthcare',null,'');
call sp_insert_data_science_functional_class('Advertising',null,'');
call sp_insert_data_science_functional_class('Music Composition',null,'');
call sp_insert_data_science_functional_class('Development',null,'');
call sp_insert_data_science_functional_class('Politics',null,'');
call sp_insert_data_science_functional_class('Manufacturing',null,'');
call sp_insert_data_science_functional_class('Emotion Analysis',null,'');
call sp_insert_data_science_functional_class('Finance',null,'');
call sp_insert_data_science_functional_class('Augmented Reality',null,'');
call sp_insert_data_science_functional_class('Security',null,'');
call sp_insert_data_science_functional_class('Travel',null,'');
call sp_insert_data_science_functional_class('Environmental Monitoring',null,'');
call sp_insert_data_science_functional_class('Healthcare',null,'');
call sp_insert_data_science_functional_class('Education',null,'');
call sp_insert_data_science_functional_class('Transportation',null,'');
call sp_insert_data_science_functional_class('E-commerce',null,'');
call sp_insert_data_science_functional_class('Gaming',null,'');
call sp_insert_data_science_functional_class('Robotics',null,'');
call sp_insert_data_science_functional_class('Robotics',null,'');
call sp_insert_data_science_functional_class('Text Input',null,'');
call sp_insert_data_science_functional_class('Accessibility',null,'');
call sp_insert_data_science_functional_class('Maritime',null,'');
call sp_insert_data_science_functional_class('Education',null,'');
call sp_insert_data_science_functional_class('Education',null,'');
call sp_insert_data_science_functional_class('Emergency Response',null,'');
call sp_insert_data_science_functional_class('Retail',null,'');
call sp_insert_data_science_functional_class('Crowdsourcing',null,'');
call sp_insert_data_science_functional_class('Media',null,'');
call sp_insert_data_science_functional_class('Email Management',null,'');
call sp_insert_data_science_functional_class('Environmental Science',null,'');
call sp_insert_data_science_functional_class('Product Development',null,'');
call sp_insert_data_science_functional_class('Education',null,'');
call sp_insert_data_science_functional_class('Finance',null,'');
call sp_insert_data_science_functional_class('Finance',null,'');
call sp_insert_data_science_functional_class('E-commerce',null,'');
call sp_insert_data_science_functional_class('Audio',null,'');
call sp_insert_data_science_functional_class('Emotion Analysis',null,'');
call sp_insert_data_science_functional_class('Insurance',null,'');
call sp_insert_data_science_functional_class('Energy Management',null,'');
call sp_insert_data_science_functional_class('Parental Monitoring',null,'');
call sp_insert_data_science_functional_class('Navigation',null,'');
call sp_insert_data_science_functional_class('Sports Analytics',null,'');
call sp_insert_data_science_functional_class('Computer Vision',null,'');
call sp_insert_data_science_functional_class('Natural Language Processing',null,'');
call sp_insert_data_science_functional_class('Finance',null,'');
call sp_insert_data_science_functional_class('Robotics',null,'');
call sp_insert_data_science_functional_class('Conversational AI',null,'');
call sp_insert_data_science_functional_class('Predictive Maintenance',null,'');
call sp_insert_data_science_functional_class('Healthcare',null,'');
call sp_insert_data_science_functional_class('Recommendation Systems',null,'');
call sp_insert_data_science_functional_class('Computer Vision',null,'');
call sp_insert_data_science_functional_class('Finance',null,'');
call sp_insert_data_science_functional_class('Natural Language Processing',null,'');
call sp_insert_data_science_functional_class('Sports Analytics',null,'');
call sp_insert_data_science_functional_class('Energy Management',null,'');
call sp_insert_data_science_functional_class('Virtual Reality',null,'');
call sp_insert_data_science_functional_class('Speech Recognition',null,'');
call sp_insert_data_science_functional_class('Text Summarization',null,'');
call sp_insert_data_science_functional_class('Human Resources',null,'');
call sp_insert_data_science_functional_class('Healthcare',null,'');
call sp_insert_data_science_functional_class('Environmental Science',null,'');
call sp_insert_data_science_functional_class('Agriculture',null,'');
call sp_insert_data_science_functional_class('Natural Language Processing',null,'');
call sp_insert_data_science_functional_class('Content Creation',null,'');
call sp_insert_data_science_functional_class('Social Media Analysis',null,'');
call sp_insert_data_science_functional_class('Computer Vision',null,'');
call sp_insert_data_science_functional_class('Transportation',null,'');
call sp_insert_data_science_functional_class('Gaming',null,'');
call sp_insert_data_science_functional_class('E-commerce',null,'');
call sp_insert_data_science_functional_class('Computer Vision',null,'');
call sp_insert_data_science_functional_class('Conversational AI',null,'');
call sp_insert_data_science_functional_class('Finance',null,'');
call sp_insert_data_science_functional_class('Marketing',null,'');
call sp_insert_data_science_functional_class('Security',null,'');
call sp_insert_data_science_functional_class('Speech Recognition',null,'');
call sp_insert_data_science_functional_class('Text Analysis',null,'');
call sp_insert_data_science_functional_class('Customer Retention',null,'');
call sp_insert_data_science_functional_class('Human Resources',null,'');
call sp_insert_data_science_functional_class('Recommendation Systems',null,'');
call sp_insert_data_science_functional_class('Computer Vision',null,'');
call sp_insert_data_science_functional_class('Security',null,'');
call sp_insert_data_science_functional_class('Transportation',null,'');
call sp_insert_data_science_functional_class('Document Classification',null,'');
call sp_insert_data_science_functional_class('Environmental Monitoring',null,'');
call sp_insert_data_science_functional_class('Customer Support',null,'');
call sp_insert_data_science_functional_class('Speech Synthesis',null,'');
call sp_insert_data_science_functional_class('Natural Language Processing',null,'');
call sp_insert_data_science_functional_class('Market Analysis',null,'');
call sp_insert_data_science_functional_class('Natural Language Processing',null,'');
call sp_insert_data_science_functional_class('Robotics',null,'');
call sp_insert_data_science_functional_class('Healthcare',null,'');
call sp_insert_data_science_functional_class('Education',null,'');
call sp_insert_data_science_functional_class('Energy Management',null,'');
call sp_insert_data_science_functional_class('Emotion Analysis',null,'');
call sp_insert_data_science_functional_class('Healthcare',null,'');
call sp_insert_data_science_functional_class('Media',null,'');
call sp_insert_data_science_functional_class('Education',null,'');
call sp_insert_data_science_functional_class('Geology',null,'');
call sp_insert_data_science_functional_class('Social Media Analysis',null,'');
call sp_insert_data_science_functional_class('Computer Vision',null,'');
call sp_insert_data_science_functional_class('Law Enforcement',null,'');
call sp_insert_data_science_functional_class('Agriculture',null,'');
call sp_insert_data_science_functional_class('Meteorology',null,'');
call sp_insert_data_science_functional_class('Customer Lifetime Value',null,'');
call sp_insert_data_science_functional_class('Supply Chain Management',null,'');
call sp_insert_data_science_functional_class('Natural Language Processing',null,'');
call sp_insert_data_science_functional_class('Manufacturing',null,'');
call sp_insert_data_science_functional_class('Recommendation Systems',null,'');
call sp_insert_data_science_functional_class('Text Generation',null,'');
call sp_insert_data_science_functional_class('Robotics',null,'');
call sp_insert_data_science_functional_class('Human Resources',null,'');
call sp_insert_data_science_functional_class('Home Automation',null,'');
call sp_insert_data_science_functional_class('Agriculture',null,'');
call sp_insert_data_science_functional_class('Job Matching',null,'');
call sp_insert_data_science_functional_class('Healthcare',null,'');
call sp_insert_data_science_functional_class('Advertising',null,'');
call sp_insert_data_science_functional_class('Music Composition',null,'');
call sp_insert_data_science_functional_class('Development',null,'');
call sp_insert_data_science_functional_class('Politics',null,'');
call sp_insert_data_science_functional_class('Manufacturing',null,'');
call sp_insert_data_science_functional_class('Emotion Analysis',null,'');
call sp_insert_data_science_functional_class('Finance',null,'');
call sp_insert_data_science_functional_class('Augmented Reality',null,'');
call sp_insert_data_science_functional_class('Security',null,'');
call sp_insert_data_science_functional_class('Travel',null,'');
call sp_insert_data_science_functional_class('Environmental Monitoring',null,'');
call sp_insert_data_science_functional_class('Healthcare',null,'');
call sp_insert_data_science_functional_class('Education',null,'');
call sp_insert_data_science_functional_class('Transportation',null,'');
call sp_insert_data_science_functional_class('E-commerce',null,'');
call sp_insert_data_science_functional_class('Gaming',null,'');
call sp_insert_data_science_functional_class('Robotics',null,'');
call sp_insert_data_science_functional_class('Robotics',null,'');
call sp_insert_data_science_functional_class('Text Input',null,'');
call sp_insert_data_science_functional_class('Accessibility',null,'');
call sp_insert_data_science_functional_class('Maritime',null,'');
call sp_insert_data_science_functional_class('Education',null,'');
call sp_insert_data_science_functional_class('Education',null,'');
call sp_insert_data_science_functional_class('Emergency Response',null,'');
call sp_insert_data_science_functional_class('Retail',null,'');
call sp_insert_data_science_functional_class('Crowdsourcing',null,'');
call sp_insert_data_science_functional_class('Media',null,'');
call sp_insert_data_science_functional_class('Email Management',null,'');
call sp_insert_data_science_functional_class('Environmental Science',null,'');
call sp_insert_data_science_functional_class('Product Development',null,'');
call sp_insert_data_science_functional_class('Education',null,'');
call sp_insert_data_science_functional_class('Finance',null,'');
call sp_insert_data_science_functional_class('Finance',null,'');
call sp_insert_data_science_functional_class('E-commerce',null,'');
call sp_insert_data_science_functional_class('Audio',null,'');
call sp_insert_data_science_functional_class('Emotion Analysis',null,'');
call sp_insert_data_science_functional_class('Insurance',null,'');
call sp_insert_data_science_functional_class('Energy Management',null,'');
call sp_insert_data_science_functional_class('Parental Monitoring',null,'');
call sp_insert_data_science_functional_class('Navigation',null,'');
call sp_insert_data_science_functional_class('Sports Analytics',null,'');

-- create table data_science_algos
CREATE TABLE data_science_algorithms_master (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    model_class_id INT NULL,
    where_used TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    FOREIGN KEY (model_class_id) REFERENCES data_science_model_classes(id)
);

-- create stored procedure to insert data science algorithms
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_data_science_algos`(IN `alog_name` VARCHAR(255), IN `model_class` VARCHAR(255), IN `description` TEXT, IN `where_used` TEXT)
BEGIN
    DECLARE model_class_id INT DEFAULT null;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
    IF model_class = '' THEN
        INSERT INTO data_science_algorithms_master (name, description, model_class_id, where_used) VALUES (alog_name, description, null, where_used );
    ELSE
        SELECT 
            id INTO model_class_id 
        FROM
            data_science_model_classes
        WHERE
            name = model_class;

        INSERT INTO data_science_algorithms_master (name, description, model_class_id, where_used) VALUES (alog_name, description, model_class_id, where_used );
    END IF;
    COMMIT;
END$$
DELIMITER ;

-- insert records
call sp_insert_data_science_algos('One-Class SVM','Anomaly Detection','A modification of SVMs used for anomaly detection.','Fraud detection, Network security');
call sp_insert_data_science_algos('Isolation Forest','Anomaly Detection','An ensemble-based algorithm that uses random forests for efficient anomaly detection.','Fraud detection, Quality assurance');
call sp_insert_data_science_algos('k-Nearest Neighbors (k-NN)','Anomaly Detection','Identifies anomalies by looking at the distance to the k nearest neighbors in a feature space.','Intrusion detection, Fault detection');
call sp_insert_data_science_algos('DBSCAN (Density-Based Spatial Clustering of Applications with Noise)','Anomaly Detection','Clustering algorithm that can identify noise points that dont belong to any cluster.','Outlier detection, Data Analysis');
call sp_insert_data_science_algos('Mahalanobis Distance','Anomaly Detection','Measures distance between a point and a distribution, not just the nearest point.','Multivariate outlier detection');
call sp_insert_data_science_algos('Local Outlier Factor (LOF)','Anomaly Detection','Measures local deviation of density of a given sample with respect to its neighbors.','Fraud detection, Intrusion detection');
call sp_insert_data_science_algos('Autoencoder Neural Networks','Anomaly Detection','Neural networks trained to reconstruct input data, anomalies cause high reconstruction error.','Fraud detection, Machine maintenance');
call sp_insert_data_science_algos('Hidden Markov Model (HMM)','Anomaly Detection','Statistical model that can represent observed data as a sequence of states.','Speech recognition, Network Intrusion');
call sp_insert_data_science_algos('Robust Random Cut Forest (RRCF)','Anomaly Detection','Ensemble method for detecting anomalies in streaming data.','Real-time anomaly detection, IoT');
call sp_insert_data_science_algos('Elliptic Envelope','Anomaly Detection','Creates a "safe zone" within which data is considered normal. Data points outside are anomalies.','Fraud detection, Sensor netwo');
call sp_insert_data_science_algos('Principal Component Analysis (PCA)-based Anomaly Detection','Anomaly Detection','Uses principal components to capture the majority of data variance, anomalies are deviations.','Credit card fraud detection, Quality control');
call sp_insert_data_science_algos('Gaussian Mixture Model (GMM)','Anomaly Detection','Assumes that the data is generated by a mixture of several Gaussian distributions.','Market segmentation, Image processing');
call sp_insert_data_science_algos('Recursive Least Squares (RLS)','Anomaly Detection','Adaptive filtering algorithm with the aim of recursively finding the coefficients that minimize an error criterion.','Signal processing, Adaptive control');
call sp_insert_data_science_algos('t-Digest','Anomaly Detection','A probabilistic data structure for accurately estimating percentile ranks within a data stream.','Real-time analytics, Monitoring systems');
call sp_insert_data_science_algos('Tukeys Fences','Anomaly Detection','A simple robust method based on Interquartile Range (IQR) to detect outliers in data.','Data cleaning, Pre-processing');
call sp_insert_data_science_algos('Exponential Smoothing State Space Model (ETS)','Anomaly Detection','Applies exponential smoothing to model time series data, useful for detecting anomalies in such data.','Time series analysis, Monitoring systems');
call sp_insert_data_science_algos('Seasonal-Trend decomposition using LOESS (STL)','Anomaly Detection','Decomposes a time series into seasonal, trend, and residual components, anomalies appear in the residual.','Time series analysis, Signal processing');
call sp_insert_data_science_algos('Change Point Detection','Anomaly Detection','Detects points where statistical properties of a sequence change, used to identify anomalies.','Quality control, Network monitoring');
call sp_insert_data_science_algos('Conditional Variational Autoencoder (CVAE)','Anomaly Detection','A type of autoencoder that conditions its input on additional information, better for high-dimensional data.','Image processing, Text data');
call sp_insert_data_science_algos('Long Short-Term Memory (LSTM)','Anomaly Detection','A type of recurrent neural network suitable for sequence data, able to detect anomalies in temporal data.','Time series analysis, Natural Language Processing');
call sp_insert_data_science_algos('Locality-Sensitive Hashing (LSH)','Approximate Algorithms','Hashing method for performing approximate nearest neighbor search.','Large-scale image search, Document similarity');
call sp_insert_data_science_algos('Simulated Annealing','Approximate Algorithms','A probabilistic algorithm to find an approximate solution to optimization and search problems.','Optimization, Scheduling');
call sp_insert_data_science_algos('Tabu Search','Approximate Algorithms','Uses memory structures to escape local optimality, thus offering an approximate solution.','Route planning, Scheduling');
call sp_insert_data_science_algos('Genetic Algorithm','Approximate Algorithms','Inspired by natural evolution, used to find approximate solutions to optimization problems.','Parameter tuning, Optimization');
call sp_insert_data_science_algos('Particle Swarm Optimization','Approximate Algorithms','A heuristic optimization algorithm that uses swarm intelligence.','Function optimization, Neural network training');
call sp_insert_data_science_algos('Ant Colony Optimization','Approximate Algorithms','Mimics the foraging behavior of ants to find approximate solutions to difficult problems.','Network design, Routing');
call sp_insert_data_science_algos('Greedy Randomized Adaptive Search Procedures (GRASP)','Approximate Algorithms','A multi-start metaheuristic for combinatorial problems, consisting of constructions followed by local search.','Scheduling, Network design');
call sp_insert_data_science_algos('Differential Evolution','Approximate Algorithms','An evolutionary algorithm that optimizes by iteratively improving candidate solutions.','Function optimization, Parameter tuning');
call sp_insert_data_science_algos('Hill Climbing','Approximate Algorithms','An iterative algorithm that starts with a solution and tries to find a better one by making small changes.','Local optimization, Game playing');
call sp_insert_data_science_algos('Bee Algorithm','Approximate Algorithms','Mimics the food foraging behavior of honey bee colonies.','Optimization, Clustering');
call sp_insert_data_science_algos('Harmony Search','Approximate Algorithms','Inspired by the improvisation process of musicians, used for numerical optimization.','Function optimization, Design');
call sp_insert_data_science_algos('Random Forests (Approximate Mode)','Approximate Algorithms','A variant of Random Forests that approximates solutions for speed-ups.','Classification, Regression');
call sp_insert_data_science_algos('K-Means++','Approximate Algorithms','An optimized initialization method for K-Means clustering to speed up convergence.','Clustering, Data segmentation');
call sp_insert_data_science_algos('Approximate Nearest Neighbors (ANN)','Approximate Algorithms','Finds nearly the closest points to a query point, skipping some calculations for speed.','Information retrieval, Computer vision');
call sp_insert_data_science_algos('Monte Carlo Simulation','Approximate Algorithms','Uses randomness to solve problems that might be deterministic in principle.','Risk assessment, Financial modeling');
call sp_insert_data_science_algos('Markov Chain Monte Carlo (MCMC)','Approximate Algorithms','A class of algorithms for sampling from a probability distribution.','Bayesian inference, Data science');
call sp_insert_data_science_algos('CMA-ES (Covariance Matrix Adaptation Evolution Strategy)','Approximate Algorithms','Evolutionary algorithm for difficult non-linear non-convex optimization problems.','Optimization, Parameter tuning');
call sp_insert_data_science_algos('UCB1 (Upper Confidence Bound)','Approximate Algorithms','A multi-armed bandit algorithm that provides a good trade-off between exploration and exploitation.','Online advertising, Game playing');
call sp_insert_data_science_algos('Bootstrapping','Approximate Algorithms','A resampling technique used to estimate sampling distributions.','Statistics, Machine learning');
call sp_insert_data_science_algos('BIRCH (Balanced Iterative Reducing and Clustering using Hierarchies)','Approximate Algorithms','An online-learning algorithm for clustering large datasets.','Data mining, Large-scale clustering');
call sp_insert_data_science_algos('FastDTW (Dynamic Time Warping)','Approximate Algorithms','An approximate Dynamic Time Warping algorithm thats optimized for speed.','Speech recognition, Time-series analysis');
call sp_insert_data_science_algos('FP-Growth','Association Rule Learning','Efficiently discovers frequent item sets in a database.','Recommender systems, Text mining');
call sp_insert_data_science_algos('Apriori','Association Rule Learning','Identifies frequent individual items in the database and extends them to larger and larger item sets.','Market basket analysis, Web usage mining');
call sp_insert_data_science_algos('Eclat','Association Rule Learning','A depth-first search algorithm for mining frequent itemsets more efficiently.','Market Basket Analysis, Recommender Systems');
call sp_insert_data_science_algos('FP-Growth','Association Rule Learning','A frequent pattern algorithm that represents the database in the form of a tree.','Market Basket Analysis, Feature Engineering');
call sp_insert_data_science_algos('GRI (Generalized Rule Induction)','Association Rule Learning','Generalizes rule induction to handle noisy and incomplete data.','Medical Diagnostics, Text Mining');
call sp_insert_data_science_algos('CBA (Classification Based on Association)','Association Rule Learning','An algorithm that combines classification and association rule mining.','Text Classification, Sentiment Analysis');
call sp_insert_data_science_algos('OPUS Miner','Association Rule Learning','An algorithm for top-k itemset mining, considering both frequent and rare itemsets.','Biological Data Analysis, Text Mining');
call sp_insert_data_science_algos('CMAR (Classification based on Multiple Association Rules)','Association Rule Learning','Extends CBA to include multiple rules for classification.','Financial Forecasting, Customer Behavior Analysis');
call sp_insert_data_science_algos('LCM (Linear time Closed itemset Miner)','Association Rule Learning','Efficiently finds closed itemsets in large datasets.','Text Mining, Image Analysis');
call sp_insert_data_science_algos('Tertius','Association Rule Learning','Generates non-redundant rules by focusing on exceptions.','Text Mining, Fraud Detection');
call sp_insert_data_science_algos('RARM (Rare Association Rule Mining)','Association Rule Learning','Focuses on discovering rare or infrequent association rules.','Medical Research, Fault Detection');
call sp_insert_data_science_algos('CAR (Class Association Rules)','Association Rule Learning','Association rules that have a class label as the consequent.','Text Classification, Medical Diagnosis');
call sp_insert_data_science_algos('Zero Latency','Association Rule Learning','Designed for real-time association rule learning.','Real-time Analytics, Monitoring Systems');
call sp_insert_data_science_algos('SeqRules (Sequential Rules)','Association Rule Learning','Discovers rules in sequences rather than itemsets.','Web Usage Mining, Predictive Maintenance');
call sp_insert_data_science_algos('Hyper-M','Association Rule Learning','Finds both positive and negative association rules.','Credit Scoring, Social Network Analysis');
call sp_insert_data_science_algos('DIC (Dynamic Itemset Counting)','Association Rule Learning','Dynamic variation of Apriori to improve performance.','Market Basket Analysis, Recommender Systems');
call sp_insert_data_science_algos('Relim (Recursive Elimination)','Association Rule Learning','A recursive algorithm to discover frequent itemsets without candidate generation.','Text Mining, Network Analysis');
call sp_insert_data_science_algos('SaM (Split and Merge)','Association Rule Learning','Splits and merges itemsets to find complex patterns.','Bioinformatics, Financial Analysis');
call sp_insert_data_science_algos('LCMseq (Linear time Closed frequent sequence mining)','Association Rule Learning','An extension of LCM for mining frequent sequences.','Customer Journey Analysis, Bioinformatics');
call sp_insert_data_science_algos('Charm','Association Rule Learning','An efficient algorithm for mining closed itemsets.','Data Summarization, Text Mining');
call sp_insert_data_science_algos('Deeps','Association Rule Learning','Depth-first search enumeration to find frequent patterns.','Network Security, Log Analysis');
call sp_insert_data_science_algos('MSApriori (Multiple Support Apriori)','Association Rule Learning','Extends Apriori to allow different minimum supports for different items.','E-commerce, Personalized Recommendations');
call sp_insert_data_science_algos('RElim','Association Rule Learning','A simple, stack-based algorithm for mining recursively enumerable itemsets.','Intrusion Detection, Market Research');
call sp_insert_data_science_algos('BigFIM & DistEclat','Association Rule Learning','Distributed versions of Apriori and Eclat for big data scenarios.','Big Data Analysis, Cloud Computing');
call sp_insert_data_science_algos('Affinity Propagation','Clustering Algorithms','Data clustering algorithm that identifies a set of exemplars among data points.','Document clustering, Image segmentation');
call sp_insert_data_science_algos('Expectation-Maximization (EM)','Clustering Algorithms','Estimates the maximum likelihood parameters of a statistical model in cases where the equations cannot be solved directly.','Clustering, Data imputation');
call sp_insert_data_science_algos('k-Means','Clustering Algorithms','Partitions data into k clusters based on feature similarity.','Customer segmentation, Image segmentation');
call sp_insert_data_science_algos('Agglomerative Clustering','Clustering Algorithms','Builds a hierarchy of clusters by recursively merging or splitting groups.','Hierarchical document organization, Taxonomies');
call sp_insert_data_science_algos('DBSCAN (Density-Based Spatial Clustering of Applications with Noise)','Clustering Algorithms','Clusters data based on density, identifies noise and outliers.','Anomaly detection, Spatial data analysis');
call sp_insert_data_science_algos('Gaussian Mixture Model (GMM)','Clustering Algorithms','Assumes that data is generated from a mixture of several Gaussian distributions.','Image segmentation, Speech recognition');
call sp_insert_data_science_algos('Spectral Clustering','Clustering Algorithms','Uses the eigenvalues of a similarity matrix to reduce dimensionality before clustering.','Community detection, Computer vision');
call sp_insert_data_science_algos('Mean Shift','Clustering Algorithms','Finds modes in a density function, which effectively locates the center of each cluster.','Object tracking, Video segmentation');
call sp_insert_data_science_algos('Affinity Propagation','Clustering Algorithms','Sends messages between pairs of data points to form clusters.','Example-based recognition, Image segmentation');
call sp_insert_data_science_algos('Birch (Balanced Iterative Reducing and Clustering using Hierarchies)','Clustering Algorithms','Incrementally constructs a tree representation. Useful for large datasets.','Large dataset clustering, Real-time clustering');
call sp_insert_data_science_algos('OPTICS (Ordering Points To Identify the Clustering Structure)','Clustering Algorithms','Similar to DBSCAN, but allows cluster density to vary.','Anomaly detection, Hierarchical clustering');
call sp_insert_data_science_algos('Hierarchical K-means','Clustering Algorithms','Combines hierarchical and k-means clustering for improved efficiency.','Large-scale data clustering, Image segmentation');
call sp_insert_data_science_algos('CURE (Clustering Using Representatives)','Clustering Algorithms','Uses representative points in clusters to allow for handling of arbitrary shapes.','Spatial data analysis, Network analysis');
call sp_insert_data_science_algos('PAM (Partitioning Around Medoids)','Clustering Algorithms','Similar to k-Means but uses actual data points as cluster centers.','Finance, Biology');
call sp_insert_data_science_algos('CLARANS (Clustering Large Applications based upon RANdomized Search)','Clustering Algorithms','Variation of PAM optimized for large datasets.','Large datasets, Spatial databases');
call sp_insert_data_science_algos('Fuzzy C-Means','Clustering Algorithms','Assigns data to one or more clusters based on probability.','Image processing, Text clustering');
call sp_insert_data_science_algos('Density-Peak','Clustering Algorithms','Finds cluster centers as density peaks in data space.','Anomaly detection, Image segmentation');
call sp_insert_data_science_algos('Jarvis-Patrick Clustering','Clustering Algorithms','Clusters based on shared nearest neighbors.','Chemical informatics, Pattern recognition');
call sp_insert_data_science_algos('SUBCLU (Subspace Clustering)','Clustering Algorithms','Detects clusters in different subspaces of a dataset.','High-dimensional data, Text mining');
call sp_insert_data_science_algos('CLIQUE (Clustering In QUEst)','Clustering Algorithms','Grid-based, partitions data space into non-overlapping rectangles and finds clusters.','High-dimensional data, Spatial data mining');
call sp_insert_data_science_algos('SNN (Shared Nearest Neighbor)','Clustering Algorithms','Uses shared nearest neighbors to improve density-based clustering.','Text mining, Document clustering');
call sp_insert_data_science_algos('CHAMELEON','Clustering Algorithms','Uses a two-phase approach, creating a sparse graph and then partitioning it.','High-dimensional clustering, Image analysis');
call sp_insert_data_science_algos('TADPole (Topology Adaptive Density-Based PoLynomial Clustering)','Clustering Algorithms','Polynomial partitioning of data density for clustering.','Bioinformatics, Robotics');
call sp_insert_data_science_algos('QT (Quality Threshold)','Clustering Algorithms','Finds clusters that meet a minimum quality criterion, unlike k-Means.','Gene expression analysis, Text mining');
call sp_insert_data_science_algos('COBWEB','Clustering Algorithms','Conceptual clustering algorithm creating a hierarchical tree.','Concept learning, Categorical data clustering');
call sp_insert_data_science_algos('ROCK (RObust Clustering using linKs)','Clustering Algorithms','Similar to agglomerative but optimized for categorical data.','Categorical data, Market research');
call sp_insert_data_science_algos('EM (Expectation–Maximization)','Clustering Algorithms','Generalizes GMM by including an E-step and M-step in the computation.','Image segmentation, Natural Language Processing');
call sp_insert_data_science_algos('Self-Organizing Maps (SOMs)','Clustering Algorithms','Neural network-based, maps high-dimensional data to lower dimensions.','Visualization, Image recognition');
call sp_insert_data_science_algos('Balanced Iterative Reducing and Clustering using Hierarchies (BIRCH)','Clustering Algorithms','Incremental clustering method that dynamically builds a tree of cluster features.','Streaming data, Large datasets');
call sp_insert_data_science_algos('Canopy Clustering','Clustering Algorithms','Pre-clustering step to reduce the input size for a subsequent more expensive algorithm.','Text clustering, Large datasets');
call sp_insert_data_science_algos('STING (STatistical INformation Grid)','Clustering Algorithms','Uses grid-based multi-resolution statistical info for clustering.','Spatial data, Image recognition');
call sp_insert_data_science_algos('MCODE (Molecular Complex Detection)','Clustering Algorithms','Specifically used for clustering in bioinformatics, particularly in network graphs.','Bioinformatics, Network analys');
call sp_insert_data_science_algos('COCO (Common Objects in Context)','Computer Vision','A large-scale object detection, segmentation, and captioning dataset.','Object Detection');
call sp_insert_data_science_algos('Convolutional Neural Networks (CNN)','Computer Vision','Specialized deep learning architecture for processing visual data.','Image recognition, Video analysis');
call sp_insert_data_science_algos('OpenCV (Haar Cascades)','Computer Vision','Object detection method used for face detection in real-time.','Face detection, Object detection');
call sp_insert_data_science_algos('Histogram of Oriented Gradients (HOG)','Computer Vision','Feature descriptor used in computer vision and image processing for object detection.','Object detection, Video surveillance');
call sp_insert_data_science_algos('Scale-Invariant Feature Transform (SIFT)','Computer Vision','Algorithm to detect and describe local features in images.','Image matching, Object recognition');
call sp_insert_data_science_algos('YOLO (You Only Look Once)','Computer Vision','Real-time object detection system that detects objects in a single pass.','Real-time object detection');
call sp_insert_data_science_algos('Support Vector Machines (SVM)','Computer Vision','Supervised learning model used for classification and regression tasks.','Text and hypertext categorization, Face detection');
call sp_insert_data_science_algos('GANs (Generative Adversarial Networks)','Computer Vision','Algorithm consisting of two neural networks, pitting one against the other.','Image generation, Data augmentation');
call sp_insert_data_science_algos('R-CNN (Regions with CNN)','Computer Vision','Object detection framework that uses a set of object proposals with CNN features.','Object detection, Image segmentation');
call sp_insert_data_science_algos('Optical Flow','Computer Vision','Pattern of apparent motion of image objects between two consecutive frames.','Motion analysis, Object tracking');
call sp_insert_data_science_algos('K-means clustering','Computer Vision','Partitional clustering algorithm used in image segmentation.','Image segmentation, Image compression');
call sp_insert_data_science_algos('Fast R-CNN','Computer Vision','An improved version of R-CNN that is more efficient in both training and detection.','Object detection, Image segmentation');
call sp_insert_data_science_algos('Zernike Moments','Computer Vision','Feature descriptors used for shape description and recognition.','Shape recognition, Medical imaging');
call sp_insert_data_science_algos('Mask R-CNN','Computer Vision','Extension of Faster R-CNN that adds a segmentation mask for each object instance.','Object segmentation, Instance segmentation');
call sp_insert_data_science_algos('Template Matching','Computer Vision','Technique used in matching a portion of an image to a template image.','Object recognition, Quality control');
call sp_insert_data_science_algos('PCA (Principal Component Analysis)','Computer Vision','Dimensionality reduction technique used to emphasize variation and bring out strong patterns.','Face recognition, Image compression');
call sp_insert_data_science_algos('Fourier Transform','Computer Vision','Mathematical transform used in image analysis, often for pattern recognition.','Image analysis, Pattern recognition');
call sp_insert_data_science_algos('Watershed Algorithm','Computer Vision','Image segmentation algorithm based on topographical interpretation of the image.','Medical imaging, Object separation');
call sp_insert_data_science_algos('AdaBoost','Computer Vision','Ensemble learning method to improve the classification performance.','Object detection, Face recognition');
call sp_insert_data_science_algos('Active Contour Model (Snakes)','Computer Vision','Energy-minimizing spline guided by external constraint forces and image forces.','Boundary detection, Shape approximation');
call sp_insert_data_science_algos('U-Net','Computer Vision','An architecture for semantic segmentation in biomedical image segmentation.','Medical imaging, Semantic segmentation');
call sp_insert_data_science_algos('SSIM (Structural Similarity Index)','Computer Vision','Method for comparing two images.','Image quality assessment');
call sp_insert_data_science_algos('VGG Net','Computer Vision','Deep learning architecture known for its depth.','Image classification, Object recognition');
call sp_insert_data_science_algos('Radon Transform','Computer Vision','Integral transform used to detect lines in images.','Medical imaging, Industrial inspection');
call sp_insert_data_science_algos('Laplacian of Gaussian (LoG)','Computer Vision','Edge detection algorithm.','Image analysis, Computer vision');
call sp_insert_data_science_algos('ResNet (Residual Networks)','Computer Vision','Deep learning architecture designed to deal with vanishing gradient problem.','Image classification, Object detection');
call sp_insert_data_science_algos('Conditional Random Fields (CRF)','Computer Vision','Statistical modeling method often used in pattern recognition.','Image segmentation, Object recognition');
call sp_insert_data_science_algos('Eigenfaces','Computer Vision','Approach to face recognition that uses PCA.','Face recognition, Security systems');
call sp_insert_data_science_algos('Non-negative Matrix Factorization (NMF)','Computer Vision','Factorization method used to decompose high-dimensional vectors into a lower-dimensional representation.','Feature learning, Image processing');
call sp_insert_data_science_algos('SURF (Speeded-Up Robust Features)','Computer Vision','Interest point detector and descriptor, faster than SIFT.','Object recognition, Image stitching');
call sp_insert_data_science_algos('Affine SIFT (ASIFT)','Computer Vision','Algorithm that simulates a series of sample views of the initial images, then applies SIFT on each.','Image matching, Object recognition');
call sp_insert_data_science_algos('C4.5 and C5.0','Decision Trees','Algorithms to generate a decision tree, later improved as C5.0.','Data mining, Financial analysis');
call sp_insert_data_science_algos('C4.5','Decision Trees','Generates a decision tree, commonly used in data mining.','Data Mining, Decision support');
call sp_insert_data_science_algos('ID3 (Iterative Dichotomiser 3)','Decision Trees','Basic decision tree algorithm that uses Information Gain.','Text categorization, Medical diagnosis');
call sp_insert_data_science_algos('CART (Classification and Regression Trees)','Decision Trees','Splits data into subsets to form a tree for both classification and regression tasks.','Medicine, Marketing');
call sp_insert_data_science_algos('CHAID (Chi-Square Automatic Interaction Detection)','Decision Trees','Uses Chi-squared tests to identify interactions between variables.','Marketing, Risk assessment');
call sp_insert_data_science_algos('QUEST (Quick, Unbiased, Efficient Statistical Tree)','Decision Trees','Designed to address the bias in binary splits in continuous variables.','Market segmentation, Biostatistics');
call sp_insert_data_science_algos('MARS (Multivariate Adaptive Regression Splines)','Decision Trees','Extends decision trees to handle numerical data and missing values.','Medical data analysis, Automotive');
call sp_insert_data_science_algos('Random Forest','Decision Trees','Ensemble of Decision Trees, each trained on a different subset of the data.','Fraud detection, Object recognition');
call sp_insert_data_science_algos('Gradient Boosted Trees','Decision Trees','Boosting technique applied to decision trees for performance optimization.','Web search ranking, Ecology');
call sp_insert_data_science_algos('AdaBoost','Decision Trees','Boosting technique that focuses on classification errors for iterative improvement.','Face recognition, Spam filtering');
call sp_insert_data_science_algos('XGBoost','Decision Trees','Scalable and accurate implementation of gradient boosting.','Competitions, Retail');
call sp_insert_data_science_algos('Conditional Inference Trees','Decision Trees','Non-parametric class of decision trees to mitigate overfitting.','Bioinformatics, Epidemiology');
call sp_insert_data_science_algos('Extremely Randomized Trees (Extra Trees)','Decision Trees','Adds randomness to model to decrease the variance for better generalization.','Text recognition, Aerial Image analysis');
call sp_insert_data_science_algos('Rotation Forest','Decision Trees','Builds multiple decision trees by randomly rotating feature subspaces.','Text classification, Drug discovery');
call sp_insert_data_science_algos('Oblivious Trees','Decision Trees','Each level of the tree uses the same feature for all data points.','Game theory, Financial prediction');
call sp_insert_data_science_algos('Hoeffding Trees (VFDT)','Decision Trees','Suitable for handling large data streams in real-time.','Network security, Data streams');
call sp_insert_data_science_algos('Perfect Random Tree Ensembles','Decision Trees','Utilizes totally random trees in an ensemble, allowing extremely fast training.','Real-time applications, Large-scale data');
call sp_insert_data_science_algos('Incremental Decision Trees','Decision Trees','Allow for incremental, online learning.','Real-time trading, Sensor data');
call sp_insert_data_science_algos('Fuzzy Decision Trees','Decision Trees','Incorporates fuzzy logic to deal with uncertainties.','Control systems, Robotics');
call sp_insert_data_science_algos('Alternating Decision Trees (ADTrees)','Decision Trees','Combines boosting and decision tree for improved performance.','Text categorization, Sentiment analysis');
call sp_insert_data_science_algos('Logistic Model Trees (LMT)','Decision Trees','Incorporates logistic regression functions at the leaves.','Bioinformatics, Customer churn prediction');
call sp_insert_data_science_algos('t-Distributed Stochastic Neighbor Embedding (t-SNE)','Dimensionality Reduction','Nonlinear dimensionality reduction useful for visualizing high-dimensional data.','Data visualization, Genome interpretation');
call sp_insert_data_science_algos('SVD (Singular Value Decomposition)','Dimensionality Reduction','Factorizes a matrix into three other matrices.','Recommender systems, Natural language processing');
call sp_insert_data_science_algos('Eigenvectors and Eigenvalues','Dimensionality Reduction','Core of Principal Component Analysis (PCA) used for reducing dimensionality.','Face recognition, Financial risk assessment');
call sp_insert_data_science_algos('t-Distributed Stochastic Neighbor Embedding (t-SNE)','Dimensionality Reduction','Reduces the dimensionality of data while trying to keep similar instances close.','Data visualization, Image processing');
call sp_insert_data_science_algos('Non-negative Matrix Factorization (NMF)','Dimensionality Reduction','Factorizes a non-negative matrix into two low-rank non-negative matrices.','Text mining, Image processing');
call sp_insert_data_science_algos('Principal Component Analysis (PCA)','Dimensionality Reduction','Linear technique to reduce dimensions, maximize variance','Data Visualization, Noise Reduction');
call sp_insert_data_science_algos('Linear Discriminant Analysis (LDA)','Dimensionality Reduction','Finds the linear combinations of features that characterize two or more classes','Classification, Pattern Recognition');
call sp_insert_data_science_algos('Autoencoders','Dimensionality Reduction','Neural Networks that can learn compressed representations of data','Feature Learning, Anomaly Detection');
call sp_insert_data_science_algos('Singular Value Decomposition (SVD)','Dimensionality Reduction','Factorizes the original data into three matrices, often used in collaborative filtering','Recommendation Systems, Information Retrieval');
call sp_insert_data_science_algos('Isomap','Dimensionality Reduction','Non-linear technique that aims to preserve geodesic (curved) distances','Manifold Learning, Data Visualization');
call sp_insert_data_science_algos('Sammon Mapping','Dimensionality Reduction','Non-linear technique focused on preserving pairwise distances','Data Visualization, Pattern Recognition');
call sp_insert_data_science_algos('Factor Analysis','Dimensionality Reduction','Identifies underlying relationships between observed variables','Psychology, Social Sciences, Marketing');
call sp_insert_data_science_algos('Independent Component Analysis (ICA)','Dimensionality Reduction','Linear technique to find statistically independent components','Blind Source Separation, Financial Analysis');
call sp_insert_data_science_algos('Gaussian Random Projection','Dimensionality Reduction','Reduces dimensionality by projecting data into a random subspace','Text Mining, Image Retrieval');
call sp_insert_data_science_algos('Canonical Correlation Analysis (CCA)','Dimensionality Reduction','Finds the relationships between two sets of variables','Multimodal Learning, Image Registration');
call sp_insert_data_science_algos('Multidimensional Scaling (MDS)','Dimensionality Reduction','Non-linear technique to visualize the similarity of individual cases of a dataset','Social Sciences, Market Research');
call sp_insert_data_science_algos('Locally-Linear Embedding (LLE)','Dimensionality Reduction','Manifold learning technique to preserve local neighbor distances','Manifold Learning, Face Recognition');
call sp_insert_data_science_algos('Laplacian Eigenmaps','Dimensionality Reduction','Finds a low-dimensional representation of data residing on a manifold','Manifold Learning, Data Visualization');
call sp_insert_data_science_algos('Kernel PCA','Dimensionality Reduction','Kernelized version of PCA for non-linear dimensionality reduction','Classification, Data Visualization');
call sp_insert_data_science_algos('Spectral Embedding','Dimensionality Reduction','Learns a non-linear representation of data using spectral theory','Data Visualization, Clustering');
call sp_insert_data_science_algos('Restricted Boltzmann Machine (RBM)','Dimensionality Reduction','Stochastic neural network for learning probability distributions','Feature Learning, Classification');
call sp_insert_data_science_algos('UMAP (Uniform Manifold Approximation and Projection)','Dimensionality Reduction','Effective for high-dimensional data','Data Visualization, General Data Analysis');
call sp_insert_data_science_algos('Diffusion Maps','Dimensionality Reduction','Non-linear technique that employs diffusion processes','Manifold Learning, Data Visualization');
call sp_insert_data_science_algos('Quadratic Discriminant Analysis (QDA)','Dimensionality Reduction','Generalizes LDA for non-linear separability','Classification, Pattern Recognition');
call sp_insert_data_science_algos('Partial Least Squares (PLS)','Dimensionality Reduction','Finds the directions that maximize covariance between input and output','Chemometrics, Multivariate Calibration');
call sp_insert_data_science_algos('Random Forest Embedding','Dimensionality Reduction','Uses the leaf nodes of random forest trees as a form of non-linear encoding','Classification, Regression');
call sp_insert_data_science_algos('Discriminant Correspondence Analysis (DCA)','Dimensionality Reduction','Extension of LDA focusing on discriminative features','Text Mining, Image Classification');
call sp_insert_data_science_algos('Variational Autoencoder (VAE)','Dimensionality Reduction','Probabilistic approach to autoencoding, useful for generative models','Generative Models, Data Generation');
call sp_insert_data_science_algos('Sparse PCA','Dimensionality Reduction','Variation of PCA that also considers sparsity','Feature Selection, Data Compression');
call sp_insert_data_science_algos('Matrix Factorization','Dimensionality Reduction','General technique to decompose a matrix into constituent parts, often used in recommendation systems','Recommendation Systems, NLP');
call sp_insert_data_science_algos('Maximal Margin Criterion (MMC)','Dimensionality Reduction','Finds the projection that maximizes the margin between different classes','Classification, Data Visualization');
call sp_insert_data_science_algos('Truncated SVD','Dimensionality Reduction','Similar to SVD but with reduced number of singular values/components','Text Mining, Information Retrieval');
call sp_insert_data_science_algos('Generalized Discriminant Analysis (GDA)','Dimensionality Reduction','Extends LDA and PCA for non-linear dimensionality reduction','Data Visualization, Pattern Recognition');
call sp_insert_data_science_algos('Stochastic Proximity Embedding (SPE)','Dimensionality Reduction','Focuses on preserving pairwise proximities between data points','Data Visualization, Chemometrics');
call sp_insert_data_science_algos('Viterbi Algorithm','Dynamic Programming','Finds the most likely sequence of hidden states in a Hidden Markov Model.','Speech recognition, Decoding in error-correcting codes');
call sp_insert_data_science_algos('Random Forest','Ensemble Methods','An ensemble of decision trees, often trained with the "bagging" method.','Fraud detection, Object recognition');
call sp_insert_data_science_algos('Gradient Boosting','Ensemble Methods','Builds strong predictive models by combining multiple weak models.','Web search ranking, Ecology');
call sp_insert_data_science_algos('AdaBoost','Ensemble Methods','Boosting technique to construct a strong classifier from multiple weak classifiers.','Object detection, Face recognition');
call sp_insert_data_science_algos('XGBoost','Ensemble Methods','Optimized gradient-boosting library meant to be highly efficient, flexible and portable.','Kaggle competitions, Classification problems');
call sp_insert_data_science_algos('CatBoost','Ensemble Methods','Gradient boosting library that provides categorical data support.','Categorical data problems, Kaggle competitions');
call sp_insert_data_science_algos('Random Forest','Ensemble Methods','Ensemble of decision trees, usually trained with the "bagging" method.','Classification, Regression');
call sp_insert_data_science_algos('LightGBM','Ensemble Methods','Gradient boosting framework that uses tree-based learning algorithms.','Classification, Regression');
call sp_insert_data_science_algos('AdaBoost','Ensemble Methods','Boosting method to create a strong classifier from multiple weak classifiers.','Classification, Object detection');
call sp_insert_data_science_algos('Random Forest','Ensemble Methods','Ensemble of decision trees, usually trained with the "bagging" method.','Classification, Regression');
call sp_insert_data_science_algos('LightGBM','Ensemble Methods','Gradient boosting framework that uses tree-based learning algorithms.','Classification, Regression');
call sp_insert_data_science_algos('Bayesian Networks','Graphical Models','Represents a set of variables and their conditional dependencies via a directed acyclic graph (DAG).','Medical diagnosis, Risk analysis');
call sp_insert_data_science_algos('Random Search','Hyperparameter Tuning','Searches randomly through a specified subset of hyperparameters.','Model Optimization');
call sp_insert_data_science_algos('Random Search','Hyperparameter Tuning','Searches randomly through a specified subset of hyperparameters.','Model Optimization');
call sp_insert_data_science_algos('Word2Vec','Natural Language Processing','Neural network-based model for representing words as vectors.','Semantic search, Machine translation');
call sp_insert_data_science_algos('Skip-gram','Natural Language Processing','Model in word2vec to represent each word in a large text as a vector in a continuous vector space.','Word embeddings, Text analysis');
call sp_insert_data_science_algos('Latent Semantic Analysis (LSA)','Natural Language Processing','Technique in NLP and information retrieval for extracting the contextual meaning of words.','Document classification, Information retrieval');
call sp_insert_data_science_algos('Scaled Exponential Linear Unit (SELU)','Neural Networks','Activation function that leads to self-normalizing neural networks.','Deep learning models');
call sp_insert_data_science_algos('RNN (Recurrent Neural Network)','Neural Networks','Neural network with loops to allow information persistence; good for sequence analysis.','Time series analysis, Natural language processing');
call sp_insert_data_science_algos('CNN (Convolutional Neural Network)','Neural Networks','Specialized kind of neural network for processing data with a grid topology like images.','Image recognition, Computer vision');
call sp_insert_data_science_algos('Bidirectional RNN','Neural Networks','Consists of two RNNs, one taking the input in a forward sense and the other in a backward sense.','Machine translation, Speech recognition');
call sp_insert_data_science_algos('GAN (Generative Adversarial Networks)','Neural Networks','Two neural networks contesting with each other in a game framework.','Image generation, Data augmentation');
call sp_insert_data_science_algos('U-Net','Neural Networks','Special type of CNN designed for semantic image segmentation.','Medical image segmentation, Object detection');
call sp_insert_data_science_algos('LSTM (Long Short-Term Memory)','Neural Networks','Special kind of RNN capable of learning long-term dependencies.','Speech recognition, Video analysis');
call sp_insert_data_science_algos('GRU (Gated Recurrent Unit)','Neural Networks','Simplified version of LSTM, often computationally more efficient.','Natural language processing, Time series analysis');
call sp_insert_data_science_algos('Leaky ReLU','Neural Networks','A variant of ReLU that allows a small gradient for negative values.','Deep Learning models');
call sp_insert_data_science_algos('Autoencoders','Neural Networks','Neural Networks that are trained to attempt to copy their input to their output.','Data Compression, Anomaly Detection');
call sp_insert_data_science_algos('Dropout','Neural Networks','A regularization technique for reducing overfitting by randomly setting a fraction of input units to 0.','Deep Learning Models');
call sp_insert_data_science_algos('Wasserstein GAN (WGAN)','Neural Networks','An improvement over traditional GANs, provides more stable training.','Image Generation');
call sp_insert_data_science_algos('Transformer Networks','Neural Networks','Attention mechanism that handles dependencies regardless of their distance in the input sequence.','Natural Language Processing, Translation');
call sp_insert_data_science_algos('Multilayer Perceptrons (MLP)','Neural Networks','A feedforward neural network model consisting of at least three layers of nodes.','Image recognition, Text analysis');
call sp_insert_data_science_algos('Radial Basis Function Networks','Neural Networks','A type of feedforward neural network.','Time-series prediction, System control');
call sp_insert_data_science_algos('Restricted Boltzmann Machines (RBM)','Neural Networks','Generative stochastic artificial neural network that can learn a probability distribution over its set of inputs.','Feature learning, Image classification');
call sp_insert_data_science_algos('Neural Turing Machines','Neural Networks','Adds external memory capabilities to neural networks.','Algorithm learning, Program synthesis');
call sp_insert_data_science_algos('LSTM (Long Short-Term Memory)','Neural Networks','Special kind of RNN capable of learning long-term dependencies.','Speech recognition, Video analysis');
call sp_insert_data_science_algos('GRU (Gated Recurrent Unit)','Neural Networks','Simplified version of LSTM, often computationally more efficient.','Natural language processing, Time series analysis');
call sp_insert_data_science_algos('Leaky ReLU','Neural Networks','A variant of ReLU that allows a small gradient for negative values.','Deep Learning models');
call sp_insert_data_science_algos('Autoencoders','Neural Networks','Neural Networks that are trained to attempt to copy their input to their output.','Data Compression, Anomaly Detection');
call sp_insert_data_science_algos('Dropout','Neural Networks','A regularization technique for reducing overfitting by randomly setting a fraction of input units to 0.','Deep Learning Models');
call sp_insert_data_science_algos('Wasserstein GAN (WGAN)','Neural Networks','An improvement over traditional GANs, provides more stable training.','Image Generation');
call sp_insert_data_science_algos('Transformer Networks','Neural Networks','Attention mechanism that handles dependencies regardless of their distance in the input sequence.','Natural Language Processing, Translation');
call sp_insert_data_science_algos('BERT (Bidirectional Encoder Representations from Transformers)','NLP','Pre-training of deep bidirectional representations from unlabeled text.','Text classification, Sentiment analysis');
call sp_insert_data_science_algos('GloVe (Global Vectors for Word Representation)','NLP','An unsupervised learning algorithm for obtaining vector representations for words.','Text Analysis');
call sp_insert_data_science_algos('GloVe (Global Vectors for Word Representation)','NLP','An unsupervised learning algorithm for obtaining vector representations for words.','Text Analysis');
call sp_insert_data_science_algos('Gradient Descent','Optimization','First-order iterative optimization algorithm for finding the minimum of a function.','Machine Learning, Data Mining');
call sp_insert_data_science_algos('Mini-batch Gradient Descent','Optimization','Variation of the gradient descent algorithm that splits the training dataset into small batches.','Large-Scale Machine Learning');
call sp_insert_data_science_algos('Nelder-Mead Method','Optimization','Direct search method for unconstrained optimization.','Model Fitting');
call sp_insert_data_science_algos('Stochastic Gradient Descent (SGD)','Optimization','Iterative method for optimizing an objective function with suitable smoothness properties.','Large-scale machine learning');
call sp_insert_data_science_algos('Gradient Descent','Optimization','First-order iterative optimization algorithm for finding the minimum of a function.','Machine Learning, Data Mining');
call sp_insert_data_science_algos('Mini-batch Gradient Descent','Optimization','Variation of the gradient descent algorithm that splits the training dataset into small batches.','Large-Scale Machine Learning');
call sp_insert_data_science_algos('Nelder-Mead Method','Optimization','Direct search method for unconstrained optimization.','Model Fitting');
call sp_insert_data_science_algos('Genetic Algorithms','Optimization Algorithms','Searches for optimal solutions using mechanisms inspired by natural evolution.','Optimization problems, Feature selection');
call sp_insert_data_science_algos('Ant Colony Optimization','Optimization Algorithms','Simulates the foraging behavior of ants to find optimal paths.','Network routing, Optimization problems');
call sp_insert_data_science_algos('Simulated Annealing','Optimization Algorithms','Probabilistic technique for approximating the global optimum of a given function.','Optimization problems, Circuit design');
call sp_insert_data_science_algos('Particle Swarm Optimization','Optimization Algorithms','Uses a swarm of agents to find optimal solutions in a search-space.','Optimization problems, Neural network training');
call sp_insert_data_science_algos('Bayesian Networks','Probabilistic Models','Probabilistic graphical model representing a set of variables and their conditional dependencies.','Diagnosis, Gene regulatory networks');
call sp_insert_data_science_algos('Factorization Machines','Recommender Systems','General predictor working with real valued feature vectors.','Recommender systems, Predictive modeling');
call sp_insert_data_science_algos('Ridge Regression','Regression Algorithms','Linear least squares with L2 regularization.','Predictive modeling, Data fitting');
call sp_insert_data_science_algos('LASSO Regression','Regression Algorithms','Linear regression that includes L1 regularization.','Compressed sensing, Predictive modeling');
call sp_insert_data_science_algos('Elastic Net','Regression Algorithms','Regularized regression method that linearly combines the L1 and L2 penalties of the LASSO and Ridge.','Sparse models, Feature selection');
call sp_insert_data_science_algos('Poisson Regression','Regression Algorithms','A type of generalized linear model (GLM) used for predicting numerical count outcomes.','Traffic forecasting, Incident prediction');
call sp_insert_data_science_algos('Q-Learning','Reinforcement Learning','Learns a policy that tells an agent what action to take under what circumstances.','Game playing, Robot navigation');
call sp_insert_data_science_algos('Deep Q Network (DQN)','Reinforcement Learning','Extends Q-Learning by using a neural network to estimate Q-values.','Autonomous vehicles, Financial trading');
call sp_insert_data_science_algos('Policy Gradients','Reinforcement Learning','A type of reinforcement learning algorithm where the policy is directly optimized.','Robotics, Game playing');
call sp_insert_data_science_algos('Actor-Critic','Reinforcement Learning','Combines value-based and policy-based reinforcement learning.','Robotics, Resource management');
call sp_insert_data_science_algos('Temporal Difference Learning','Reinforcement Learning','Learns from the difference between successive predictions.','Game playing, Robotics');
call sp_insert_data_science_algos('Proximal Policy Optimization','Reinforcement Learning','An algorithm that performs optimization to achieve better policy in RL environments.','Game playing, Real-world robotics');
call sp_insert_data_science_algos('Reinforce','Reinforcement Learning','Policy-gradient method for reinforcement learning.','Game playing, Optimization');
call sp_insert_data_science_algos('Thompson Sampling','Reinforcement Learning','Algorithm for solving the multi-armed bandit problem with a probabilistic framework.','Online ad placement, Clinical trials');
call sp_insert_data_science_algos('PPO (Proximal Policy Optimization)','Reinforcement Learning','Optimizes the control of non-linear, non-convex systems.','Robotics, Game Playing');
call sp_insert_data_science_algos('Value Iteration','Reinforcement Learning','Computes the optimal value function for an MDP (Markov Decision Process).','Game Theory, Economics');
call sp_insert_data_science_algos('Q-Learning','Reinforcement Learning','Uses value functions to solve the MDP.','Robotics, Game Playing');
call sp_insert_data_science_algos('DQN (Deep Q-Network)','Reinforcement Learning','Combines Q-Learning and deep neural networks.','Game Playing, Automated Vehicles');
call sp_insert_data_science_algos('PPO (Proximal Policy Optimization)','Reinforcement Learning','Optimizes the control of non-linear, non-convex systems.','Robotics, Game Playing');
call sp_insert_data_science_algos('Value Iteration','Reinforcement Learning','Computes the optimal value function for an MDP (Markov Decision Process).','Game Theory, Economics');
call sp_insert_data_science_algos('Q-Learning','Reinforcement Learning','Uses value functions to solve the MDP.','Robotics, Game Playing');
call sp_insert_data_science_algos('DQN (Deep Q-Network)','Reinforcement Learning','Combines Q-Learning and deep neural networks.','Game Playing, Automated Vehicles');
call sp_insert_data_science_algos('Fuzzy Logic Systems','Rule-based Algorithms','Logical calculus for reasoning that is approximate rather than fixed and exact.','Control systems, Pattern recognition');
call sp_insert_data_science_algos('A* Search Algorithm','Search and Optimization','Finds the least-cost path from a given initial node to a goal node.','Pathfinding, Network routing');
call sp_insert_data_science_algos('Hidden Markov Model (HMM)','Sequential Data','Models sequences and time-series data.','Speech recognition, Language modeling');
call sp_insert_data_science_algos('Conditional Random Fields (CRF)','Sequential Data','Probabilistic framework for labeling and segmenting structured data.','Named entity recognition, Image segmentation');
call sp_insert_data_science_algos('Conditional Random Fields (CRF)','Sequential Models','Discriminative model to predict a sequence of states for a sequence of input samples.','Text-to-speech, Named entity recognition');
call sp_insert_data_science_algos('FFT (Fast Fourier Transform)','Signal Processing','Efficient algorithm to compute the Discrete Fourier Transform and its inverse.','Signal and Image Analysis');
call sp_insert_data_science_algos('FFT (Fast Fourier Transform)','Signal Processing','Efficient algorithm to compute the Discrete Fourier Transform and its inverse.','Signal and Image Analysis');
call sp_insert_data_science_algos('Jensen-Shannon Divergence','Similarity Measures','Measures the similarity between two probability distributions.','Text similarity, Image retriev');
call sp_insert_data_science_algos('Monte Carlo Methods','Simulation Methods','Use randomness to solve problems that might be deterministic in principle.','Risk assessment, Game playing');
call sp_insert_data_science_algos('Latent Dirichlet Allocation (LDA)','Specialized Algorithms','A topic modeling algorithm that assigns topics to documents and words to topics.','Natural language processing, Information retrieval');
call sp_insert_data_science_algos('Expectation-Maximization (EM)','Statistical Algorithms','Iteratively estimates the maximum likelihood or maximum a posteriori (MAP) estimate of parameters.','Clustering, Missing data imputation');
call sp_insert_data_science_algos('Chi-Square Test','Statistical Methods','Tests the independence of two events.','Feature selection');
call sp_insert_data_science_algos('Z-Test','Statistical Methods','Tests the mean of a distribution.','Data Analysis, Quality Assurance');
call sp_insert_data_science_algos('T-Test','Statistical Methods','Determines if the means of two sets of data are significantly different from each other.','Data Analysis, Hypothesis Testing');
call sp_insert_data_science_algos('Chi-Square Test','Statistical Methods','Tests the independence of two events.','Feature selection');
call sp_insert_data_science_algos('Z-Test','Statistical Methods','Tests the mean of a distribution.','Data Analysis, Quality Assurance');
call sp_insert_data_science_algos('T-Test','Statistical Methods','Determines if the means of two sets of data are significantly different from each other.','Data Analysis, Hypothesis Testing');
call sp_insert_data_science_algos('Linear Regression','Supervised Learning','Predicts a continuous outcome variable based on one or more predictor variables.','Financial forecasting, Risk assessment');
call sp_insert_data_science_algos('Logistic Regression','Supervised Learning','Used for binary classification problems.','Email spam filtering, Medical diagnosis');
call sp_insert_data_science_algos('Decision Trees','Supervised Learning','Builds a model in the form of a tree structure, used for both classification and regression.','Customer segmentation, Stock prediction');
call sp_insert_data_science_algos('Naive Bayes','Supervised Learning','Based on Bayes theorem and often used for text classification.','Text classification, Sentiment analysis');
call sp_insert_data_science_algos('Support Vector Machines (SVM)','Supervised Learning','Tries to find a hyperplane that best separates different classes.','Text categorization, Handwriting recognition');
call sp_insert_data_science_algos('K-Nearest Neighbors (KNN)','Supervised Learning','Classifies a data point based on how its neighbors are classified.','Recommender systems, Pattern recognition');
call sp_insert_data_science_algos('Ridge Regression','Supervised Learning','Linear regression with L2 regularization.','Finance, Economics');
call sp_insert_data_science_algos('Lasso Regression','Supervised Learning','Linear regression with L1 regularization.','Bioinformatics, Compressed sensing');
call sp_insert_data_science_algos('Elastic Net','Supervised Learning','Linear regression with both L1 and L2 regularization.','Text mining, Genomics');
call sp_insert_data_science_algos('Gaussian Naive Bayes','Supervised Learning','Naive Bayes classifier suitable for continuous data.','Text classification, Medical diagnosis');
call sp_insert_data_science_algos('Multinomial Naive Bayes','Supervised Learning','Naive Bayes for discrete data, often for text classification.','Text mining, Sentiment analysis');
call sp_insert_data_science_algos('Linear Discriminant Analysis (LDA)','Supervised Learning','Used to find a linear combination of features that characterizes or separates classes.','Dimensionality reduction, Classification');
call sp_insert_data_science_algos('Quadratic Discriminant Analysis (QDA)','Supervised Learning','Generalizes LDA to allow quadratic decision boundaries.','Pattern recognition, Medical diagnosis');
call sp_insert_data_science_algos('K-Nearest Neighbors (K-NN)','Supervised Learning','Classifies a data point based on how its neighbors are classified.','Classification, Regression');
call sp_insert_data_science_algos('Naive Bayes Classifier','Supervised Learning','Based on Bayes’ Theorem, for classification tasks.','Spam filtering, Sentiment analysis');
call sp_insert_data_science_algos('Decision Trees','Supervised Learning','Tree-like model of decisions.','Classification, Regression');
call sp_insert_data_science_algos('Support Vector Machines (SVM)','Supervised Learning','Effective in high dimensional spaces, used for classification and regression.','Text categorization, Face detection');
call sp_insert_data_science_algos('Gaussian Naive Bayes','Supervised Learning','A variant of Naive Bayes assuming that features follow a Gaussian distribution.','Text categorization, Spam filtering');
call sp_insert_data_science_algos('K-Nearest Neighbors (K-NN)','Supervised Learning','Classifies a data point based on how its neighbors are classified.','Classification, Regression');
call sp_insert_data_science_algos('Naive Bayes Classifier','Supervised Learning','Based on Bayes’ Theorem, for classification tasks.','Spam filtering, Sentiment analysis');
call sp_insert_data_science_algos('Decision Trees','Supervised Learning','Tree-like model of decisions.','Classification, Regression');
call sp_insert_data_science_algos('Support Vector Machines (SVM)','Supervised Learning','Effective in high dimensional spaces, used for classification and regression.','Text categorization, Face detection');
call sp_insert_data_science_algos('Levenshtein distance','Text Similarity','Measures the minimum number of edits required to change one string into another.','Spell checking, DNA sequence alignment');
call sp_insert_data_science_algos('ARIMA (AutoRegressive Integrated Moving Average)','Time Series','Combines autoregression and moving average models.','Stock Price Prediction, Weather Forecasting');
call sp_insert_data_science_algos('SARIMA (Seasonal ARIMA)','Time Series','Extension of ARIMA that supports univariate time series data with a seasonal component.','Sales Forecasting');
call sp_insert_data_science_algos('ARIMA (AutoRegressive Integrated Moving Average)','Time Series','Combines autoregression and moving average models.','Stock Price Prediction, Weather Forecasting');
call sp_insert_data_science_algos('SARIMA (Seasonal ARIMA)','Time Series','Extension of ARIMA that supports univariate time series data with a seasonal component.','Sales Forecasting');
call sp_insert_data_science_algos('ARIMA','Time-Series Algorithms','Forecasts future values based on past values.','Stock price prediction, Weather forecasting');
call sp_insert_data_science_algos('Long Short-Term Memory (LSTM)','Time-Series Algorithms','A type of recurrent neural network capable of learning sequences.','Speech recognition, Machine translation');
call sp_insert_data_science_algos('Holt-Winters Method','Time-Series Algorithms','Exponential smoothing method for time-series forecasting with seasonality.','Stock market prediction, Sales forecasting');
call sp_insert_data_science_algos('Dynamic Time Warping (DTW)','Time-Series Algorithms','Measures similarity between two time series which may vary in speed.','Speech recognition, Gesture recognition');
call sp_insert_data_science_algos('K-Means','Unsupervised Learning','Clustering algorithm that partitions data into K distinct, non-overlapping subsets.','Market segmentation, Image compression');
call sp_insert_data_science_algos('Principal Component Analysis (PCA)','Unsupervised Learning','Reduces dimensionality by transforming to a new set of variables.','Face recognition, Data visualization');
call sp_insert_data_science_algos('Autoencoders','Unsupervised Learning','Neural networks that are trained to attempt to copy their input to their output.','Data compression, Anomaly detection');
call sp_insert_data_science_algos('k-Mode and k-Prototype','Unsupervised Learning','Variants of k-means for categorical and mixed data types.','Market research, Customer segmentation');
call sp_insert_data_science_algos('Mean Shift','Unsupervised Learning','Clustering algorithm based on density of data points.','Image segmentation, Object tracking');
call sp_insert_data_science_algos('Gaussian Mixture Model (GMM)','Unsupervised Learning','Generalizes k-means to include information about covariance structure.','Speech recognition, Image segmentation');
call sp_insert_data_science_algos('Hierarchical Clustering','Unsupervised Learning','Builds a tree of nested clusters by merging or splitting them successively.','Taxonomies, Document clustering');
call sp_insert_data_science_algos('Affinity Propagation','Unsupervised Learning','Clustering algorithm based on message passing between data points.','Image segmentation, Identifying communities in networks');
call sp_insert_data_science_algos('Non-negative Matrix Factorization (NMF)','Unsupervised Learning','Factorizes matrices into non-negative factors; used for feature extraction.','Text mining, Image analysis');
call sp_insert_data_science_algos('DBSCAN (Density-Based Spatial Clustering)','Unsupervised Learning','Clustering algorithm based on density rather than distance.','Anomaly detection, Spatial data analysis');
call sp_insert_data_science_algos('Self-Organizing Maps','Unsupervised Learning','Type of artificial neural network for unsupervised learning to produce low-dimensional representation.','Data visualization, Dimensionality reduction');
call sp_insert_data_science_algos('HDBSCAN (Hierarchical DBSCAN)','Unsupervised Learning','Extension of DBSCAN clustering algorithm to find clusters of arbitrary shape.','Clustering, Data Segmentation');
call sp_insert_data_science_algos('Agglomerative Clustering','Unsupervised Learning','A "bottom-up" approach: each observation starts in its own cluster, and pairs of clusters are merged.','Hierarchical Data Classification');
call sp_insert_data_science_algos('Hierarchical Clustering','Unsupervised Learning','Creates a tree of clusters. Ideal for hierarchical taxonomy.','Taxonomy creation, Document clustering');
call sp_insert_data_science_algos('Mean Shift Clustering','Unsupervised Learning','A sliding-window-based algorithm that aims to discover blobs in a smooth density of samples.','Image segmentation, Video tracking');
call sp_insert_data_science_algos('HDBSCAN (Hierarchical DBSCAN)','Unsupervised Learning','Extension of DBSCAN clustering algorithm to find clusters of arbitrary shape.','Clustering, Data Segmentation');
call sp_insert_data_science_algos('Agglomerative Clustering','Unsupervised Learning','A "bottom-up" approach: each observation starts in its own cluster, and pairs of clusters are merged.','Hierarchical Data Classification');
call sp_insert_data_science_algos('Viterbi Algorithm','Dynamic Programming','Used in Hidden Markov Models for finding the most likely sequence of hidden states.','Speech recognition, Bioinformatics');
call sp_insert_data_science_algos('Bellman-Ford Algorithm','Dynamic Programming','Shortest Path algorithm often used in Reinforcement Learning','Graph-based search, Networking');
call sp_insert_data_science_algos('Value Iteration','Dynamic Programming','Iterative algorithm used in Reinforcement Learning to compute the value function.','Game theory, Robotics');
call sp_insert_data_science_algos('Policy Iteration','Dynamic Programming','Used to compute the policy in Reinforcement Learning environments.','Robotics, Resource management');
call sp_insert_data_science_algos('Smith-Waterman','Dynamic Programming','Local sequence alignment; used in bioinformatics for DNA, RNA, and protein comparison.','Bioinformatics');
call sp_insert_data_science_algos('Needleman-Wunsch','Dynamic Programming','Global sequence alignment; used in bioinformatics.','Bioinformatics');
call sp_insert_data_science_algos('Dynamic Time Warping (DTW)','Dynamic Programming','Algorithm for measuring similarity between two time sequences.','Speech recognition, Time-series analysis');
call sp_insert_data_science_algos('Q-Learning','Dynamic Programming','Reinforcement learning algorithm for learning a policy.','Robotics, Game playing');
call sp_insert_data_science_algos('SARSA','Dynamic Programming','On-policy Reinforcement Learning algorithm.','Robotics, Control systems');
call sp_insert_data_science_algos('Monte Carlo Tree Search (MCTS)','Dynamic Programming','Used for decision-making in large state/action space problems.','Game playing (like Go, Chess)');
call sp_insert_data_science_algos('A* Search','Dynamic Programming','Pathfinding algorithm that uses heuristics; can be viewed as an extension of Dijkstras.','Robotics, Video games');
call sp_insert_data_science_algos('Dijkstras Algorithm','Dynamic Programming','Shortest path algorithm in a graph; fundamental to various applications.','Networking, GIS');
call sp_insert_data_science_algos('Floyd-Warshall Algorithm','Dynamic Programming','All-pairs shortest paths in a weighted graph.','Networking, Operations research');
call sp_insert_data_science_algos('Expectation-Maximization (EM)','Dynamic Programming','Estimation algorithm that includes hidden states.','Clustering, Natural language processing');
call sp_insert_data_science_algos('Baum-Welch Algorithm','Dynamic Programming','Used for training Hidden Markov Models.','Speech recognition, Finance');
call sp_insert_data_science_algos('Minimum Edit Distance','Dynamic Programming','Measures the dissimilarity between two strings by computing the minimum number of operations (insertions, deletions, and substitutions) required to transform one string into the other.','Spell checking, DNA sequence alignment');
call sp_insert_data_science_algos('Longest Common Subsequence (LCS)','Dynamic Programming','Finds the longest subsequence common to all sequences in a set of sequences.','Bioinformatics, Text comparison');
call sp_insert_data_science_algos('Actor-Critic Methods','Dynamic Programming','Reinforcement Learning algorithms that combine value and policy-based methods.','Robotics, Natural language processing');
call sp_insert_data_science_algos('Forward-Backward Algorithm','Dynamic Programming','An inference algorithm for Hidden Markov Models that computes posterior marginals of all hidden state variables given a sequence of observations/emissions.','Natural language processing, Bioinformatics');
call sp_insert_data_science_algos('Dynamic Bayesian Networks','Dynamic Programming','Generalization of Hidden Markov Models to more complex temporal dynamics.','Robotics, Computer Vision');
call sp_insert_data_science_algos('Levenshtein Distance','Dynamic Programming','Measures the similarity between two strings.','Text analysis, Spell checking');
call sp_insert_data_science_algos('Optimal Control Theory','Dynamic Programming','Method to find the best possible control for a given system.','Robotics, Economics');
call sp_insert_data_science_algos('Priority Queueing (D* Algorithm)','Dynamic Programming','Pathfinding for robotics and video games with dynamic edge costs.','Robotics, Video games');
call sp_insert_data_science_algos('Suffix Trees','Dynamic Programming','Data structure for various string operations; dynamic programming is often used in its construction.','Text analysis, Bioinformatics');
call sp_insert_data_science_algos('Bidirectional Search','Dynamic Programming','Pathfinding algorithm that runs two simultaneous searches.','Robotics, Networking');
call sp_insert_data_science_algos('Conjugate Gradient Method','Dynamic Programming','Optimization algorithm for differentiable functions.','Machine learning, Image processing');
call sp_insert_data_science_algos('Upper Confidence Bound (UCB1)','Dynamic Programming','Algorithm used in multi-armed bandit problems, often used in Reinforcement Learning.','Online advertising, Game playing');
call sp_insert_data_science_algos('RRT (Rapidly-exploring Random Tree)','Dynamic Programming','Path planning algorithm.','Robotics, Autonomous vehicles');

-- crate table datascience_methods
CREATE TABLE data_science_methods_master (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT NULL,
    method_class_id INT DEFAULT null,
    use_cases TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    FOREIGN KEY (method_class_id) REFERENCES data_science_method_classes(id)
);

-- create sp
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_data_science_methods`(IN `method_name` VARCHAR(255), IN `method_class` VARCHAR(255), IN `description` TEXT, IN `where_used` TEXT)
BEGIN
    DECLARE method_class_id INT DEFAULT null;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;

    IF method_class = '' THEN
        INSERT INTO data_science_methods_master(name, description, method_class_id, use_cases) VALUES (method_name, description, null, where_used );
    ELSE
        SELECT 
            id INTO method_class_id 
        FROM
            data_science_method_classes
        WHERE
            name = method_class;

        INSERT INTO data_science_methods_master (name, description, method_class_id, use_cases) VALUES (method_name, description, method_class_id, where_used );
    END IF;
    COMMIT;
END$$
DELIMITER ;

-- insert records
call sp_insert_data_science_methods('fit','Training','Trains the model on a given dataset.', null);
call sp_insert_data_science_methods('predict','Prediction','Makes predictions on new data based on the trained model.', null);
call sp_insert_data_science_methods('transform','Transformation','Transforms the input data, often used in preprocessing steps or dimensionality reduction.', null);
call sp_insert_data_science_methods('fit_transform','Training and Transformation','Combines the fit and transform steps, often more efficient than calling them separately.', null);
call sp_insert_data_science_methods('score','Evaluation','Evaluates the models performance, often returning a single scalar value (e.g., accuracy).', null);
call sp_insert_data_science_methods('partial_fit','Incremental Training','Incremental learning, updates the model with a mini-batch of training data.', null);
call sp_insert_data_science_methods('predict_proba','Probability Prediction','Returns the probability estimates for classification problems.', null);
call sp_insert_data_science_methods('decision_function','Decision Function','Computes the distance to the separating hyperplane in algorithms like Support Vector Machines (SVM).', null);
call sp_insert_data_science_methods('inverse_transform','Inverse Transformation','Converts the data back to its original space in methods involving transformation (e.g., PCA).', null);
call sp_insert_data_science_methods('get_params','Configuration','Returns the hyperparameters of the model.', null);
call sp_insert_data_science_methods('set_params','Configuration','Sets the hyperparameters of the model.', null);
call sp_insert_data_science_methods('n_iter_','Iteration Information','Returns the number of iterations run by the solver (often an attribute rather than a method).', null);
call sp_insert_data_science_methods('coef_','Model Coefficients','Returns the weights assigned to the features (often an attribute in linear models).', null);
call sp_insert_data_science_methods('feature_importances_','Feature Importances','Gets the feature importances (often an attribute in tree-based models).', null);
call sp_insert_data_science_methods('save_model','Model Saving','Saves the trained model to disk.', null);
call sp_insert_data_science_methods('load_model','Model Loading','Loads a trained model from disk.', null);
call sp_insert_data_science_methods('compile','Compilation','Configures the model for training, often used in neural networks.', null);
call sp_insert_data_science_methods('evaluate','Evaluation','Returns the loss and any additional metrics specified during the model compilation for the evaluation dataset.', null);
call sp_insert_data_science_methods('fit_generator','Generator Training','Fits the model on data yielded batch-by-batch by a generator, often used in deep learning frameworks.', null);
call sp_insert_data_science_methods('summary','Model Summary','Provides a summary representation of the model, including the architecture and parameters, often in neural networks.', null);
call sp_insert_data_science_methods('clone','Cloning','Creates a copy of the model with the same architecture but without any learned parameters.', null);
call sp_insert_data_science_methods('cross_val_score','Cross-validation','Evaluates a score by cross-validation. Often a standalone method but closely related to model evaluation.', null);
call sp_insert_data_science_methods('partial_predict','Partial Prediction','Makes predictions on new data but in a batched or streaming manner.', null);
call sp_insert_data_science_methods('warm_start','Warm Start','Resumes training from where it was left off, using the already trained parameters as a starting point.', null);
call sp_insert_data_science_methods('staged_predict','Staged Prediction','Used in ensemble methods like Gradient Boosting to get predictions at each boosting iteration.', null);
call sp_insert_data_science_methods('validate','Model Validation','Validates the models hyperparameters and other settings before training.', null);
call sp_insert_data_science_methods('predict_log_proba','Log Probability Prediction','Returns logarithm of probability estimates in classification problems.', null);
call sp_insert_data_science_methods('predict_classes','Class Prediction','Specific to some neural network frameworks, it returns the class index with the highest probability.', null);
call sp_insert_data_science_methods('train_on_batch','Batch Training','Trains the model for a single gradient update on a batch of data. Often used in deep learning.', null);
call sp_insert_data_science_methods('reset_states','State Reset','Resets the internal states of a stateful neural network.', null);
call sp_insert_data_science_methods('apply','Model Application','Applies a function to the output of a specific layer in neural networks.', null);
call sp_insert_data_science_methods('get_weights','Model Weights','Returns the weights of the model as a list of NumPy arrays.', null);
call sp_insert_data_science_methods('set_weights','Model Weights','Sets the weights of the model with a list of NumPy arrays.', null);
call sp_insert_data_science_methods('get_layer','Layer Retrieval','Retrieves a layer by either its name or index, usually in neural networks.', null);
call sp_insert_data_science_methods('pop','Model Layer Removal','Removes the last layer in a Sequential neural network model.', null);
call sp_insert_data_science_methods('add','Model Layer Addition','Adds a layer to a Sequential neural network model.', null);
call sp_insert_data_science_methods('to_json','Model Serialization','Serializes the model structure to a JSON string.', null);
call sp_insert_data_science_methods('from_json','Model Deserialization','Loads the model from a JSON string containing the model structure.', null);
call sp_insert_data_science_methods('get_config','Model Configuration','Returns a dictionary containing the configuration of the model.', null);
call sp_insert_data_science_methods('from_config','Model Configuration','Creates a new model from its config dictionary.', null);
call sp_insert_data_science_methods('register_forward_hook','Hook Registration','Registers a forward hook in PyTorch models, allowing custom operations.', null);
call sp_insert_data_science_methods('register_backward_hook','Hook Registration','Registers a backward hook in PyTorch models, allowing custom gradient computations.', null);

-- create table data_science_models_master with columns
-- Model Name
-- Training Algorithm
-- Learning Algorithm
-- Description
-- Model Class
-- Use Cases
CREATE TABLE data_science_models_master (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT NULL,
    training_algorithm_id INT DEFAULT null,
    learning_algorithm_id INT DEFAULT null,
    model_class_id INT DEFAULT null,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    FOREIGN KEY (training_algorithm_id) REFERENCES data_science_algorithms(id),
    FOREIGN KEY (learning_algorithm_id) REFERENCES data_science_algorithms(id),
    FOREIGN KEY (model_class_id) REFERENCES data_science_model_classes(id)
);

-- create sp
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_data_science_models`(IN `model_name` VARCHAR(255), IN `model_class` VARCHAR(255), IN `learning_algoirthm` VARCHAR(255), IN `training_algoirthm` VARCHAR(255), IN `description` TEXT)
BEGIN
    DECLARE model_class_id INT DEFAULT null;
    DECLARE learning_algorithm_id INT DEFAULT null;
    DECLARE training_algorithm_id INT DEFAULT null;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;

 -- model class
    SELECT 
        id INTO model_class_id 
    FROM
        data_science_model_classes
    WHERE
        name = model_class LIMIT 1;

  -- learning algorithm
	SELECT 
		id INTO learning_algorithm_id 
	FROM
		data_science_algorithms_master
	WHERE
		name = learning_algoirthm LIMIT 1;

	IF learning_algorithm_id IS NULL THEN
		INSERT INTO data_science_algorithms_master (name, description, model_class_id, where_used) VALUES (learning_algoirthm, '', model_class_id, '');
		SELECT LAST_INSERT_ID() INTO learning_algorithm_id;
	END IF;

    -- training algorithm
	SELECT 
		id INTO training_algorithm_id 
	FROM
		data_science_algorithms_master
	WHERE
		name = training_algoirthm LIMIT 1;

	IF training_algorithm_id IS NULL THEN
		INSERT INTO data_science_algorithms_master (name, description, model_class_id, where_used) VALUES (training_algoirthm, '', model_class_id, '');
		SELECT LAST_INSERT_ID() INTO training_algorithm_id;
	END IF;


    INSERT INTO data_science_models_master (name, description, model_class_id, learning_algorithm_id, training_algorithm_id) VALUES (model_name, description, model_class_id, learning_algorithm_id, training_algorithm_id);
  
    COMMIT;
END$$
DELIMITER ;

-- create records
call sp_insert_data_science_models('Classification Models','Supervised Learning','Gradient Descent','Logistic Regression','Assigns a class label to inputs, may also provide probabilities.');
call sp_insert_data_science_models('Classification Models','Supervised Learning','Quadratic Programming','Support Vector Machines (SVM)','Determines the class of an input based on a hyperplane decision boundary.');
call sp_insert_data_science_models('Regression Models','Supervised Learning','Gradient Descent','Ridge Regression','Predicts a continuous value with L2 regularization.');
call sp_insert_data_science_models('Clustering Models','Unsupervised Learning','Iterative Refinement','K-Means','Partitions data into k clusters.');
call sp_insert_data_science_models('Recommender Systems','Collaborative Filtering','Stochastic Gradient Descent','Matrix Factorization','Recommends items based on matrix decomposition.');
call sp_insert_data_science_models('Time Series Models','Time Series Analysis','Backpropagation Through Time','Long Short-Term Memory (LSTM)','Forecasts sequences and time series data.');
call sp_insert_data_science_models('Natural Language Models','Natural Language Processing','Attention Mechanism','BERT (Transformer)','Encodes, translates, and performs various NLP tasks.');
call sp_insert_data_science_models('Object Detection Models','Computer Vision','Region Proposals + CNN','Faster R-CNN','Detects and locates objects in an image.');
call sp_insert_data_science_models('Dimensionality Reduction','Unsupervised Learning','Gradient Descent','t-distributed Stochastic Neighbor Embedding (t-SNE)','Reduces the dimensionality of data, often used for visualization.');
call sp_insert_data_science_models('Generative Models','Generative Modeling','Minimax','Generative Adversarial Networks (GAN)','Generates new data samples that resemble the training data.');
call sp_insert_data_science_models('Neural Collaborative Filtering','Collaborative Filtering','Backpropagation','Matrix Factorization + Neural Network','Recommends items based on a hybrid of matrix factorization and neural networks.');
call sp_insert_data_science_models('Sequence to Sequence Models','Sequence Modeling','Attention Mechanism','LSTMs, GRU, Transformer','Transforms sequences from one domain to another, often used for translation.');
call sp_insert_data_science_models('Text Classification','Natural Language Processing','Maximum Likelihood','Naive Bayes','Categorizes text documents into predefined classes.');
call sp_insert_data_science_models('Random Forests','Ensemble Learning','Bagging','Ensemble of Decision Trees','Performs classification or regression based on ensemble methods.');
call sp_insert_data_science_models('Graph Neural Networks','Graph-based Learning','Convolution Over Graphs','Graph Convolutional Networks (GCNs)','Performs tasks like node classification and link prediction in graph-structured data.');
call sp_insert_data_science_models('Autoencoders','Neural Networks','Backpropagation','Neural Network Autoencoder','Reduces dimensionality and reconstructs data.');
call sp_insert_data_science_models('Anomaly Detection','Anomaly Detection','Random Partitioning','Isolation Forests','Identifies anomalous or rare events in data.');
call sp_insert_data_science_models('Style Transfer','Computer Vision','Gradient Descent','Neural Style Transfer','Transfers artistic styles between images.');
call sp_insert_data_science_models('Topic Models','Natural Language Processing','Variational Inference','Latent Dirichlet Allocation (LDA)','Discovers topics in a collection of documents.');
call sp_insert_data_science_models('Bayesian Networks','Probabilistic Models','Probabilistic Graphical Models','Bayesian Estimation','Performs probabilistic reasoning and inference.');
call sp_insert_data_science_models('Reinforcement Learning','Reinforcement Learning','Temporal Difference Learning','Q-learning, Deep Q Networks','Trains agent to make sequences of decisions.');
call sp_insert_data_science_models('K-Nearest Neighbors','Supervised Learning','Instance-based Learning','Distance Metric Learning','Performs classification or regression based on the closest training samples.');
call sp_insert_data_science_models('Boosting','Ensemble Learning','Ensemble Boosting','Adaboost, Gradient Boosting','Builds a strong classifier/regressor from weak ones.');
call sp_insert_data_science_models('Speech Recognition','Speech Processing','Sequence Modeling','Hidden Markov Models','Converts spoken language into written text.');
call sp_insert_data_science_models('Variational Autoencoders','Neural Networks','Variational Inference','Neural Network Encoder + Decoder','Generates and reconstructs data, often used for generating new samples.');
call sp_insert_data_science_models('Markov Chains','Markov Models','Stochastic Process','Markov Process','Generates sequences based on transition probabilities.');
call sp_insert_data_science_models('Sparse Coding','Unsupervised Learning','Sparse Representation','Dictionary Learning','Transforms data into a sparse representation.');
call sp_insert_data_science_models('Multilayer Perceptrons','Neural Networks','Backpropagation','Feedforward Neural Networks','Performs complex mappings from inputs to outputs for classification or regression.');
call sp_insert_data_science_models('Principal Component Analysis','Unsupervised Learning','Linear Transformation','Eigenvector Decomposition','Reduces dimensionality by projecting data onto principal components.');
call sp_insert_data_science_models('Support Vector Regression','Supervised Learning','Quadratic Programming','Support Vector Machines','Predicts continuous values with margin optimization.');
call sp_insert_data_science_models('Logistic Regression','Supervised Learning','Supervised','Gradient Descent','Used for binary or multi-class classification.');
call sp_insert_data_science_models('Decision Trees','Supervised Learning','Supervised','ID3, CART, C4.5','Decision-making tree structure for classification and regression.');
call sp_insert_data_science_models('Hierarchical Clustering','Unsupervised Learning','Unsupervised','Agglomerative Clustering','Groups data points into nested clusters by hierarchy.');
call sp_insert_data_science_models('Linear Discriminant Analysis','','Supervised','Covariance Matrix','Used for dimensionality reduction and as a classification technique.');
call sp_insert_data_science_models('XGBoost','Ensemble Learning','Supervised','Gradient Boosting','Extreme Gradient Boosting, an optimized distributed gradient boosting library.');
call sp_insert_data_science_models('Expectation-Maximization','Probabilistic Models','Semi-supervised','Maximum Likelihood Estimation','Estimate the probabilities of latent variables.');
call sp_insert_data_science_models('Affinity Propagation','Clustering','Unsupervised','Graph-based Similarity','Clustering algorithm based on the concept of "message passing" between data points.');
call sp_insert_data_science_models('t-SNE','Dimensionality Reduction','Unsupervised','Non-linear Dimensionality Reduction','t-Distributed Stochastic Neighbor Embedding, often used for visualization.');
call sp_insert_data_science_models('ElasticNet','Regression','Supervised','Coordinate Descent','Linear regression with combined L1 and L2 regularization.');
call sp_insert_data_science_models('Gaussian Mixture Model','Probabilistic Models','Unsupervised','Expectation-Maximization','Mixture model that uses Gaussian distributions to model the data.');
call sp_insert_data_science_models('K-Medoids','Clustering','Unsupervised','Partitioning Algorithm','Variation of K-means that is more robust to noise and outliers.');
call sp_insert_data_science_models('Isomap','Dimensionality Reduction','Unsupervised','Shortest Path Graph','Non-linear dimensionality reduction through isometric mapping.');
call sp_insert_data_science_models('Self-Organizing Maps','Unsupervised Learning','Unsupervised','Competitive Learning','Unsupervised learning to produce low-dimensional representation of the input space.');
call sp_insert_data_science_models('Conditional Random Fields','Probabilistic Models','Supervised','Maximum Likelihood','Often used in pattern recognition and used for sequence modeling and labeling.');
call sp_insert_data_science_models('Naive Bayes Classifier','Supervised Learning','Supervised','Maximum Likelihood','Based on Bayes Theorem, and naive assumptions between features.');
call sp_insert_data_science_models('Bi-directional RNN','Neural Networks','Supervised','Backpropagation through time','Bi-directional Recurrent Neural Networks, captures information in both past and future states.');
call sp_insert_data_science_models('Long Short-Term Memory','Neural Networks','Supervised','Backpropagation through time','LSTMs are a type of RNN effective in sequence prediction problems.');
call sp_insert_data_science_models('Gradient Descent Optimization','Optimization','Optimization Algorithm','Gradient Descent','General-purpose optimization algorithm.');
call sp_insert_data_science_models('Genetic Algorithms','Evolutionary Algorithms','Optimization Algorithm','Evolutionary Algorithm','Optimization and search algorithm based on the principles of natural selection and genetics.');
call sp_insert_data_science_models('Simulated Annealing','Optimization','Optimization Algorithm','Metropolis Algorithm','Probabilistic optimization algorithm mimicking the process of annealing in metallurgy.');

-- create table data_science_models_methods_master
CREATE TABLE data_science_models_methods_master (
    id INT PRIMARY KEY AUTO_INCREMENT,
    model_id INT NOT NULL,
    method_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    FOREIGN KEY (model_id) REFERENCES data_science_models_master(id),
    FOREIGN KEY (method_id) REFERENCES data_science_methods_master(id)
);

-- create sp
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_data_science_model_methods`(IN `model_name` VARCHAR(255), IN `method_name` VARCHAR(255))
BEGIN
    DECLARE model_id INT DEFAULT null;
    DECLARE method_id INT DEFAULT null;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;

    -- model id
    SELECT 
        id INTO model_id 
    FROM
        data_science_models_master
    WHERE
        name = model_name LIMIT 1;

    -- method id
    SELECT 
        id INTO method_id 
    FROM
        data_science_methods_master
    WHERE
        name = method_name LIMIT 1;

    IF method_id IS NULL THEN
        INSERT INTO data_science_methods_master (name, description, method_class_id, use_cases) VALUES (method_name, '', null, '');
        SELECT LAST_INSERT_ID() INTO method_id;
    END IF;

	IF model_id IS NOT NULL AND method_id IS NOT NULL THEN
        INSERT INTO data_science_models_methods_master (model_id, method_id) VALUES (model_id, method_id);
    END IF;

    COMMIT;
END$$
DELIMITER ;

-- insert records
call sp_insert_data_science_model_methods('Classification Models','classify');
call sp_insert_data_science_model_methods('Classification Models','classify');
call sp_insert_data_science_model_methods('Regression Models','predict');
call sp_insert_data_science_model_methods('Clustering Models','fit_predict');
call sp_insert_data_science_model_methods('Recommender Systems','recommend');
call sp_insert_data_science_model_methods('Time Series Models','forecast');
call sp_insert_data_science_model_methods('Natural Language Models','encode');
call sp_insert_data_science_model_methods('Object Detection Models','detect');
call sp_insert_data_science_model_methods('Dimensionality Reduction','fit_transform');
call sp_insert_data_science_model_methods('Generative Models','generate');
call sp_insert_data_science_model_methods('Neural Collaborative Filtering','recommend');
call sp_insert_data_science_model_methods('Sequence to Sequence Models','encode_decode');
call sp_insert_data_science_model_methods('Text Classification','classify');
call sp_insert_data_science_model_methods('Random Forests','classify');
call sp_insert_data_science_model_methods('Graph Neural Networks','node_classify');
call sp_insert_data_science_model_methods('Autoencoders','encode');
call sp_insert_data_science_model_methods('Anomaly Detection','detect_anomaly');
call sp_insert_data_science_model_methods('Style Transfer','transfer_style');
call sp_insert_data_science_model_methods('Topic Models','fit_transform');
call sp_insert_data_science_model_methods('Bayesian Networks','infer');
call sp_insert_data_science_model_methods('Reinforcement Learning','train_episode');
call sp_insert_data_science_model_methods('K-Nearest Neighbors','classify');
call sp_insert_data_science_model_methods('Boosting','classify');
call sp_insert_data_science_model_methods('Speech Recognition','transcribe');
call sp_insert_data_science_model_methods('Variational Autoencoders','encode');
call sp_insert_data_science_model_methods('Markov Chains','generate_sequence');
call sp_insert_data_science_model_methods('Sparse Coding','transform');
call sp_insert_data_science_model_methods('Multilayer Perceptrons','classify');
call sp_insert_data_science_model_methods('Principal Component Analysis','fit_transform');
call sp_insert_data_science_model_methods('Support Vector Regression','predict');
call sp_insert_data_science_model_methods('Logistic Regression','classify');
call sp_insert_data_science_model_methods('Decision Trees','classify');
call sp_insert_data_science_model_methods('Hierarchical Clustering','fit');
call sp_insert_data_science_model_methods('Linear Discriminant Analysis','classify');
call sp_insert_data_science_model_methods('XGBoost','fit');
call sp_insert_data_science_model_methods('Expectation-Maximization','fit');
call sp_insert_data_science_model_methods('Affinity Propagation','fit_predict');
call sp_insert_data_science_model_methods('t-SNE','fit_transform');
call sp_insert_data_science_model_methods('ElasticNet','fit');
call sp_insert_data_science_model_methods('Gaussian Mixture Model','fit');
call sp_insert_data_science_model_methods('K-Medoids','fit');
call sp_insert_data_science_model_methods('Isomap','fit_transform');
call sp_insert_data_science_model_methods('Self-Organizing Maps','fit');
call sp_insert_data_science_model_methods('Conditional Random Fields','fit');
call sp_insert_data_science_model_methods('Naive Bayes Classifier','fit');
call sp_insert_data_science_model_methods('Bi-directional RNN','fit');
call sp_insert_data_science_model_methods('Long Short-Term Memory','fit');
call sp_insert_data_science_model_methods('Gradient Descent Optimization','optimize');
call sp_insert_data_science_model_methods('Genetic Algorithms','optimize');
call sp_insert_data_science_model_methods('Simulated Annealing','optimize');
call sp_insert_data_science_model_methods('Classification Models',' predict_proba');
call sp_insert_data_science_model_methods('Clustering Models',' transform');
call sp_insert_data_science_model_methods('Recommender Systems',' rank');
call sp_insert_data_science_model_methods('Natural Language Models',' translate');
call sp_insert_data_science_model_methods('Dimensionality Reduction','');
call sp_insert_data_science_model_methods('Neural Collaborative Filtering',' rank');
call sp_insert_data_science_model_methods('Sequence to Sequence Models',' translate');
call sp_insert_data_science_model_methods('Random Forests',' predict');
call sp_insert_data_science_model_methods('Graph Neural Networks',' link_predict');
call sp_insert_data_science_model_methods('Autoencoders',' decode');
call sp_insert_data_science_model_methods('Topic Models',' topic_assign');
call sp_insert_data_science_model_methods('Bayesian Networks',' sample');
call sp_insert_data_science_model_methods('Reinforcement Learning',' act');
call sp_insert_data_science_model_methods('K-Nearest Neighbors',' regress');
call sp_insert_data_science_model_methods('Boosting',' predict');
call sp_insert_data_science_model_methods('Variational Autoencoders',' decode');
call sp_insert_data_science_model_methods('Multilayer Perceptrons',' predict');
call sp_insert_data_science_model_methods('Logistic Regression',' predict_proba');
call sp_insert_data_science_model_methods('Decision Trees',' predict');
call sp_insert_data_science_model_methods('Hierarchical Clustering',' transform');
call sp_insert_data_science_model_methods('XGBoost',' predict');
call sp_insert_data_science_model_methods('Expectation-Maximization',' transform');
call sp_insert_data_science_model_methods('ElasticNet',' predict');
call sp_insert_data_science_model_methods('Gaussian Mixture Model',' predict');
call sp_insert_data_science_model_methods('K-Medoids',' transform');
call sp_insert_data_science_model_methods('Self-Organizing Maps',' transform');
call sp_insert_data_science_model_methods('Conditional Random Fields',' predict');
call sp_insert_data_science_model_methods('Naive Bayes Classifier',' predict');
call sp_insert_data_science_model_methods('Bi-directional RNN',' predict');
call sp_insert_data_science_model_methods('Long Short-Term Memory',' predict');

-- create table data_science_use_cases_master with columns
-- Use Case
-- ML Model Type
-- Industry
-- How it is Used
-- Class
CREATE TABLE data_science_use_cases_master (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    index (id),
    UNIQUE (name)
);

-- insert records
INSERT INTO data_science_use_cases_master(name, description) VALUES('Image Classification','Identifying diseases in X-rays and MRI scans.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Sentiment Analysis','To analyze customer feedback and improve service.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Fraud Detection','Identifying fraudulent transactions based on past data.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Autonomous Vehicles','For self-driving car navigation and decision-making.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Chatbots','Handling customer queries in an automated manner.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Predictive Maintenance','Predicting when machinery is likely to fail so maintenance can be scheduled.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Drug Discovery','Accelerating the discovery of new drug compounds.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Personalized Recommendations','Recommending products to customers based on their previous actions.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Video Surveillance','Identifying unauthorized activities or persons in restricted areas.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Stock Market Prediction','Forecasting stock prices or market trends based on historical data.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Language Translation','Translating text or speech from one language to another.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Sports Analytics','Analyzing player performance, strategy optimization.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Energy Management','Optimizing energy usage in smart grids.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Virtual Reality','Enhancing user interaction in a simulated environment.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Voice Recognition','For voice-activated controls in smart home devices.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Text Summarization','Summarizing long documents into shorter versions.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Talent Acquisition','Resume screening, skill matching, and automated interviews.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Medical Diagnosis','Predicting diseases based on symptoms and medical history.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Climate Modeling','Predicting climate change trends.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Precision Agriculture','Monitoring crop health, automating harvesting.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Real-time Language Translation','Translating spoken language in real-time for seamless communication.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Content Creation','Generating art, music, or textual content.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Social Network Analysis','Identifying influential nodes or spreading patterns in social networks.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Facial Recognition','Identifying or verifying a person from a digital image or video frame.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Traffic Prediction','Forecasting traffic conditions to optimize routing.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Video Game Development','For creating more challenging and dynamic game environments.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('E-commerce Price Optimization','Dynamic pricing strategies based on demand, time, and other variables.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Aerial Image Analysis','Analyzing aerial images for land assessment, crop health, etc.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Virtual Assistants','Assisting users in tasks like setting reminders, web search, etc.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Credit Scoring','Assessing the creditworthiness of customers.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Customer Segmentation','Dividing customers into segments based on purchasing habits.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Intrusion Detection Systems','Detecting unauthorized access or anomalies in network traffic.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Speech-to-Text','Transcribing spoken language into written text.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Plagiarism Detection','Detecting copied content in academic papers or articles.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Churn Prediction','Predicting which customers are likely to leave a service.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Human Resource Analytics','Predicting employee turnover, performance, etc.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Music Recommendation','Recommending music tracks based on user history.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Handwriting Recognition','Converting handwritten text into digital format.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Biometric Authentication','Authenticating individuals based on unique biological traits like fingerprint, retina, etc.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Flight Route Optimization','Determining optimal routes to minimize fuel and time.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Document Classification','Automatically sorting documents into predefined categories.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Wildlife Monitoring','Identifying and counting animals in aerial or trail camera images.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Automated Customer Support','Handling common customer issues without human intervention.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Text-to-Speech','Converting written text into spoken words.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Fake News Detection','Identifying false or misleading articles.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Market Basket Analysis','Finding associations between products purchased together.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Sentiment Analysis in Social Media','Monitoring public opinion on political issues or candidates.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Autonomous Drones','Flying drones for delivery, surveillance without human control.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Sleep Monitoring','Analyzing sleep patterns to diagnose or monitor sleep disorders.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Automated Language Tutoring','Providing personalized language learning assistance.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Smart Energy Management','Optimizing energy use in real-time for buildings or factories.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Emotional Analysis','Determining emotional states through facial recognition, text, etc.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Disease Outbreak Prediction','Predicting the spread of diseases based on various factors.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Automated Journalism','Generating news articles based on data inputs.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Adaptive Learning Systems','Tailoring educational content to individual student needs.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Earthquake Prediction','Predicting seismic activities based on historical data.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Social Media Monitoring','Tracking brand mentions and sentiment on social media platforms.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Object Tracking','Tracking the movement of objects in real-time in videos.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Predictive Policing','Using data to predict areas where crime is likely to occur.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Livestock Monitoring','Monitoring the health and location of livestock.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Weather Forecasting','Predicting weather conditions based on historical data.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Customer Lifetime Value Prediction','Estimating the total value a customer will bring over the entire relationship.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Supply Chain Optimization','Optimizing supply chain routes and inventory.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Automated Translation in Video Calls','Real-time translation of speech in video conferences.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Visual Quality Control','Detecting defects in products as they move on the assembly line.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Movie Recommendation','Recommending movies based on user preferences and behavior.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Text Generation','Generating articles, stories, and marketing copy.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Robot Navigation','Enabling robots to navigate through complex environments.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Talent Scouting','Identifying promising talent based on statistical analysis.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Smart Homes','Automating home functions like temperature control and security.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Soil Quality Prediction','Predicting soil quality for better yield.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Skill Matching in Job Portals','Matching job seekers with suitable jobs based on skills and experience.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Telemedicine','Providing medical consultations based on symptoms described.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Ad Placement','Optimizing where to place ads for maximum engagement.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Music Composition','Composing music using AI algorithms.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Automated Code Review','Identifying bugs or issues in code automatically.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Election Outcome Prediction','Predicting election outcomes based on various factors like social sentiment.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Product Quality Control','Identifying defects in products during manufacturing.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Stress Detection','Monitoring stress levels using biometric data.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Automated Billing','Generating bills automatically based on purchased items.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Augmented Reality','Superimposing digital information in the real world.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Anomaly Detection in Networks','Detecting unusual patterns that do not conform to expected behavior.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Custom Travel Planning','Customizing travel plans based on user preferences and past behavior.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Water Quality Monitoring','Continuous monitoring of water quality in rivers and reservoirs.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Seizure Prediction','Predicting epileptic seizures based on EEG data.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Automated Language Scoring','Scoring language tests and assessments automatically.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Traffic Signal Timing Optimization','Optimizing traffic signal timings to improve flow and reduce congestion.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Real-Time Auctions','Enabling real-time bidding in auctions based on market conditions.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Gaming Strategies','Developing strategies for winning in complex games like Go, Poker.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Drone Path Planning','Planning the most efficient path for drones.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Industrial Robot Training','Training robots to perform complex tasks in industries.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Predictive Text Input','Predicting the next word or phrase the user is likely to type.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Reading Assistance','Assisting in reading digital texts aloud for educational purposes.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Autonomous Sailing','Navigation and operation of autonomous ships.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Learning Style Prediction','Predicting the most effective learning style for students.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Lecture Summarization','Providing a concise summary of long lectures or presentations.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Emergency Response Optimization','Optimal allocation of resources during emergency situations.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Grocery Restocking','Predicting when items are likely to run out and need restocking.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Crowdsourced Data Analysis','Analyzing data collected from a large number of contributors.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('News Aggregation','Aggregating news from various sources based on user interest.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Email Categorization','Automatically sorting emails into categories.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Natural Disaster Prediction','Predicting natural disasters like hurricanes, floods based on climatic conditions.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Sentiment-Based Product Development','Developing products based on public sentiment and feedback.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Real-time Language Tutoring','Providing instant feedback during language learning.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Personal Financial Management','Advising on budgeting, investments, retirement planning.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Asset Management','Managing financial assets to achieve specific investment objectives.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Virtual Fitting Rooms','Trying out clothes virtually before purchasing.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Audio Mastering','Automatically mastering music tracks.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Voice-Based Emotional Analysis','Understanding emotional state based on vocal characteristics.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Fraudulent Claim Detection','Identifying potentially fraudulent insurance claims.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Optimizing Renewable Energy Outputs','Optimizing the output from renewable energy resources.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Parental Monitoring Systems','Monitoring childrens activities and alerting parents.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Indoor Positioning Systems','Locating objects or people within a building using sensors or other data.');
INSERT INTO data_science_use_cases_master(name, description) VALUES('Sports Play Analysis','Analyzing sports plays to develop strategies.');