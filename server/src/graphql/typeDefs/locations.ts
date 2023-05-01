import gql from "graphql-tag";

const locationsTypeDefs = gql`
  type Location {
    id: Int!
    name: String!
    lat: Float!
    lng: Float!
    type: String!
    site: Site!
    from: [Flight!]!
    via: [Flight!]!
    to: [Flight!]!
  }
  type Query {
    location(id: Int!): Location!
    locations(siteId: Int, type: String): [Location!]!
    locoationsPerSite(siteId: Int!): [Location!]!
    heliportsPerSite(siteId: Int!): [Location!]!
    viaPerSite(siteId: Int!): [Location!]!
  }
  input CreateLocationInput {
    name: String!
    lat: Float!
    lng: Float!
    type: String!
    siteId: Int!
  }
  input UpdateLocationInput {
    name: String
    lat: Float
    lng: Float
  }
  type Mutation {
    createLocation(data: CreateLocationInput!): Location!
    updateLocation(id: Int!, data: UpdateLocationInput!): Location!
  }
`;
export default locationsTypeDefs;
