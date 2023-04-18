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
    locations: [Location!]!
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
  type Mutation {
    createLocation(data: CreateLocationInput!): Location!
  }
`;
export default locationsTypeDefs;
