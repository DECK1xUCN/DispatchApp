import gql from "graphql-tag";

const hoistOperatorTypeDefs = gql`
  type HoistOperator {
    id: Int!
    name: String!
    flights: [Flight!]!
  }

  input CreateHoistOperator {
    name: String!
  }

  type Query {
    hoistOperators: [HoistOperator!]!
    hoistOperator(id: Int!): HoistOperator!
  }
  type Mutation {
    createHoistOperator(hoistOperator: CreateHoistOperator!): HoistOperator!
  }
`;

export default hoistOperatorTypeDefs;
