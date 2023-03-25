import gql from "graphql-tag";

const flightTypeDefs = gql`
  type Query {
    findAll: [Flight!]!
    findById(id: String!): Flight!
    findByFlightNumber(flightNumber: String!): Flight!
  }
  type Mutation {
    createFlight(data: FlightCreateInput): Flight!
    updateById(id: String!, data: FlightUpdateInput!): Flight!
    updateByFlightNumber(
      flightNumber: String!
      data: FlightUpdateInput!
    ): Flight!
  }

  type Flight {
    id: String!
    flightNumber: String!
    from: String!
    via: String!
    to: String!
    etd: DateTime!
    pax: Int!
    cargoPP: Int!
    hoistCycles: Int!
    late: Boolean!
    latenote: String
    delayCode: String
  }

  # Input types
  input FlightCreateInput {
    from: String!
    flightNumber: String!
    via: String!
    to: String!
    etd: DateTime!
    pax: Int!
    cargoPP: Int!
    hoistCycles: Int!
    late: Boolean!
    latenote: String
    delayCode: String
  }

  input FlightUpdateInput {
    from: String!
    flightNumber: String!
    via: String!
    to: String!
    etd: DateTime!
    pax: Int!
    cargoPP: Int!
    hoistCycles: Int!
    late: Boolean!
    lateNote: String
    delayCode: String
  }

  scalar DateTime
`;

export default flightTypeDefs;
