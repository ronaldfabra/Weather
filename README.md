# Weather

[![Build](https://github.com/ronaldfabra/Weather/actions/workflows/build.yml/badge.svg)](https://github.com/ronaldfabra/Weather/actions/workflows/build.yml)

[![codecov](https://codecov.io/gh/ronaldfabra/Weather/branch/master/graph/badge.svg?token=3G8XLZ41UJ)](https://codecov.io/gh/ronaldfabra/Weather)

Weather is an application for Bold to list locations and can see the weather details.

## Prerequisites

Before running the project, make sure to set up your api key correctly.

1. Clone the repository.
2. After cloning the repository, open **Weather.xcodeproj** file at the root of the project.
3. Open it and follow the instructions to add your `API_KEY`
   from [Weather Api](https://www.weatherapi.com/docs/).
4. After you get the `API_KEY` from site please go to the target **Weather**.
5. Go to **Build Settings** tab, scroll down until the end and you can find the `User-Defined` section.
6. Once you are in `User-Defined` section you will see the `User-Defined` named `API_KEY` where you need to add your required `API_KEY` in the `value` input.
7. After add yout `API_KEY` you are ready to build and run the project.

   
## Architecture

The project follows the Clean Architecture approach, using also MVVM and the DI pattern ensuring high cohesion and low coupling through layer separation:

- Domain Layer: Contains business specifications with different use cases, and domain models.
- Data Layer: Groups components associated with different data sources to get the data like network and local Core Data, such as mappers, response models (Dto), endpoints and repositories.
- Presentation Layer: Contains functionality modules (Search locations, Favorites locations) and shared components used in all the application.
- Extensions: Contains some class extensions to handle the data.
- Utils: Contain some util funcitonalities to process and handle the data.
- DIContainer: Contains a class to handle the dependency injection.

## Dependency Injection

The project uses Dependency Injection (DI) to facilitate layer separation, following the principle of dependency inversion. This prevents the domain layer from having direct references to the data layer, making the code easier to test and maintain. The DI is handle using something like the desing pattern Builder, which is to efficiently to handle the memory leak when have too many class instances.

## Unit test
Unit tests have been implemented for viewModels, use cases, repositories, database container, and utils as these components contain most of the project's logic.

## UI test
UI tests have been implemented for some views to ensure to have the expected components.

## API
- **URL base**: `https://api.weatherapi.com`
- **Api version**: `v1`
- **Available Services**:
    - Search Location: `GET /search.json?key={API_KEY}&q={query}`
    - Weather Detail: `GET /forecast.json?key={API_KEY}&q={latitude,longitude}&days={forecast_days}`
 
## Continuous Integration (CI) with GitHub Actions
A CI pipeline has been integrated using GitHub Actions to automatically validate the project. This pipeline performs the following tasks:

- **Runs Unit Tests**: Verifies that all tests pass correctly.
- **Checks Code Coverage with Codecov**: Generates a test coverage report and ensures that defined thresholds are met. this coverage can be find in `https://app.codecov.io/gh/ronaldfabra/Weather`

## Pipeline local with pipeline.sh

In addition to the GitHub Actions pipeline, you can run the same CI process locally using a **run_tests.sh** script. This script will perform all the necessary validations to ensure code quality before pushing changes to the repository. 

## Instructions to Run the Local Pipeline:

1. Make sure you have the `run_tests.sh` file in the root of the project.
2. Open a terminal in the project directory and run the following command:

   ```properties 
    ./run_tests.sh

## Other Information
- this app was developed in SwiftUI with Swift languages.
- the requests was developed using async and await that are the new structured concurrency changes that arrived in Swift 5.5 during WWDC 2021.
- the app support portrait and landscape orientation.
- the app use a local database to handle the favorites locations this with CoreData.
- the app has unit tests and ui tests to ensure the correct behavior this with Swift Tests and XCTests.
- the app support the errors handler.
- there is no any third library, all the application was made with own code.
