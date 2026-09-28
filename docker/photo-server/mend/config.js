module.exports = {
  hostRules: [
    {
      hostType: 'docker',
      matchHost: 'dhi.io',
      username: process.env.DHI_USERNAME,
      password: process.env.DHI_PASSWORD
    }
  ],
  allowedCommands: [
    "^\\./scripts/bump-doh-version\\.sh$"
  ]
};
