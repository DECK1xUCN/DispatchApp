import gql from "graphql-tag";

const locationsTypeDefs = gql`
  type Location {
    id: Int!
    name: String!
    lat: Float!
    long: Float!
    type: String!
  }
  input CreateLocationInput {
    name: String!
    lat: Float
    long: Float
    type: String!
  }
  type Query {
    location(id: Int!): Location!
    locations: [Location!]!
  }
  type Mutation {
    createLocation(input: CreateLocationInput!): Location!
  }
`;
export default locationsTypeDefs;
