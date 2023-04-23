import gql from "graphql-tag";

const hoistOperatorTypeDefs = gql`
  type HoistOperator {
    id: Int!
    name: String!
    flights: [Flight!]!
  }

  type Query {
    hoistOperators: [HoistOperator!]!
    hoistOperator(id: Int!): HoistOperator!
  }
  type Mutation {
    createHoistOperator(name: String!): HoistOperator!
    updateHoistOperator(id: Int!, name: String!): HoistOperator!
  }
`;

export default hoistOperatorTypeDefs;
