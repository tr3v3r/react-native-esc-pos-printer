// @ts-check

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'react-native-esc-pos-printer',
  tagline: 'Print receipts natively from React Native on Epson TM printers',

  url: 'https://tr3v3r.github.io',
  baseUrl: '/react-native-esc-pos-printer/',

  organizationName: 'tr3v3r',
  projectName: 'react-native-esc-pos-printer',

  onBrokenLinks: 'warn',

  trailingSlash: false,

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  markdown: {
    // .md files use standard CommonMark so raw <img> tags work as-is
    format: 'detect',
    hooks: {
      onBrokenMarkdownLinks: 'warn',
    },
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          path: '../docs',
          routeBasePath: 'docs',
          sidebarPath: './sidebars.js',
          exclude: ['**/*.pdf'],
          editUrl:
            'https://github.com/tr3v3r/react-native-esc-pos-printer/edit/main/',
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      navbar: {
        title: 'react-native-esc-pos-printer',
        items: [
          {
            type: 'docSidebar',
            sidebarId: 'docs',
            position: 'left',
            label: 'Docs',
          },
          {
            href: 'https://github.com/tr3v3r/react-native-esc-pos-printer',
            label: 'GitHub',
            position: 'right',
          },
          {
            href: 'https://www.npmjs.com/package/react-native-esc-pos-printer',
            label: 'npm',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              { label: 'Installation', to: '/docs/INSTALLATION' },
              { label: 'Quick Start', to: '/docs/QUICK_START' },
              { label: 'Printer API', to: '/docs/printer' },
            ],
          },
          {
            title: 'Links',
            items: [
              {
                label: 'GitHub',
                href: 'https://github.com/tr3v3r/react-native-esc-pos-printer',
              },
              {
                label: 'npm',
                href: 'https://www.npmjs.com/package/react-native-esc-pos-printer',
              },
              {
                label: 'Issues',
                href: 'https://github.com/tr3v3r/react-native-esc-pos-printer/issues',
              },
            ],
          },
        ],
        copyright: `react-native-esc-pos-printer · MIT License`,
      },
      prism: {
        additionalLanguages: ['bash', 'json', 'typescript', 'tsx'],
      },
    }),
};

module.exports = config;
