import gql from "graphql-tag";

const heliportsTypeDefs = gql`
  type Query {
    heliports: [Heliport!]!
    heliport(id: Int!): Heliport!
  }
  type Mutation {
    createHeliport(data: HeliportInput): Heliport!
    updateHeliport(id: String!, data: HeliportInput!): Heliport!
  }
  type Heliport {
    id: Int!
    name: String!
  }
  # Input types
  input HeliportInput {
    name: String!
  }
`;
export default heliportsTypeDefs;
