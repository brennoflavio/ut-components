# Project: UT Components

## Project Description
Components to develop Python Ubuntu Touch applications

The goal of this project is to provide a set of resusable components / funcitons to be used in Ubuntu Touch Applications.
This project is not used alone. Instead, we'll import it into other Ubuntu Touch applications

## Tech Stack
- Frontend: QT/QML
- Backend: Python

## Code Conventions
- In this project, src/Main.qml is a showcase of the components, not an actual app. So implement the component there should contain all properties to showcase how its used
- The goal of this components, is to have a good standards and a slow surface api. Most of the decisions will be made in the component itself, and the api should be simple and straithforward to implement. Its not meant to be highly customizable.
- Prefer using Ubuntu Touch QML Components when available
- This is a libary, its indended to be used by another applications to make their development easy.
- Always try to keep QML logic as simple as possible. Python should contain most of the business logic
- Do not add console.log, print calls and comments unless explicity asked
- Avoid touching python code unless asked. Mock qml data if I don't provide a python funciton

## Project Structure
- ./src/qml - QML components
- ./src//python - Python components
