## Digitally Induced Test IHP App GitHub Action
This GitHub Action runs tests for your IHP (Integrated Haskell Platform) applications using Docker.

# Inputs
This action currently does not accept any inputs.

# Outputs
This action currently does not have any outputs.

# Example usage
You can use the action in your GitHub workflow as follows:

jobs:
  tests:
    name: Run Tests
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: aronnovak/test-ihp-app
