import gql from "graphql-tag";

const hoistOperators = gql`
  type Query {
    hoistOperators: [HoistOperator!]!
    hoistOperator(id: Int!): HoistOperator!
  }
  type Mutation {
    createHoistOperator(data: HoistOperatorInput): HoistOperator!
    updateHoistOperator(id: String!, data: HoistOperatorInput!): HoistOperator!
  }
  type HoistOperator {
    id: Int!
    name: String!
  }
  # Input types
  input HoistOperatorInput {
    name: String!
  }
`;

export default hoistOperators;
