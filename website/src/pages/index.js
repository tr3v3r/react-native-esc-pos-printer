import React from 'react';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import styles from './index.module.css';

const FEATURES = [
  {
    title: 'BLE, LAN, USB & Wi-Fi',
    description: 'All major connection methods for Epson TM printers out of the box.',
  },
  {
    title: 'New Architecture Ready',
    description: "Compatible with React Native's Fabric and Turbo Modules.",
  },
  {
    title: 'Print from RN Views',
    description: 'Capture any React Native View and print it as a raster image.',
  },
  {
    title: 'Built-in Queue',
    description: 'Thread-safe print queue handles concurrent jobs without extra code.',
  },
  {
    title: 'Clear Error Descriptions',
    description: 'Detailed error codes and messages for every printer failure state.',
  },
  {
    title: 'Proxy-like API',
    description: 'Easy to extend with additional ESC/POS commands via addCommand().',
  },
];

export default function Home() {
  const { siteConfig } = useDocusaurusContext();
  return (
    <Layout title={siteConfig.title} description={siteConfig.tagline}>
      <header className={styles.hero}>
        <div className="container">
          <h1 className={styles.heroTitle}>{siteConfig.title}</h1>
          <p className={styles.heroSubtitle}>{siteConfig.tagline}</p>
          <a
            href="https://badge.fury.io/js/react-native-esc-pos-printer"
            className={styles.badge}
          >
            <img
              src="https://badge.fury.io/js/react-native-esc-pos-printer.svg"
              alt="npm version"
            />
          </a>
          <div className={styles.ctas}>
            <Link className="button button--secondary button--lg" to="/docs/INSTALLATION">
              Get Started
            </Link>
            <Link className="button button--outline button--lg" to="/docs/QUICK_START">
              View Examples
            </Link>
          </div>
        </div>
      </header>

      <main>
        <section className={styles.section}>
          <div className="container">
            <h2>Features</h2>
            <div className={styles.features}>
              {FEATURES.map((f) => (
                <div key={f.title} className={styles.feature}>
                  <h3>{f.title}</h3>
                  <p>{f.description}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className={styles.section}>
          <div className="container">
            <h2>Installation</h2>
            <div className={styles.installGrid}>
              <div>
                <h3>React Native</h3>
                <pre className={styles.code}>
                  <code>yarn add react-native-esc-pos-printer</code>
                </pre>
              </div>
              <div>
                <h3>Expo</h3>
                <pre className={styles.code}>
                  <code>
                    npx expo install react-native-esc-pos-printer{'\n'}
                    npx expo prebuild
                  </code>
                </pre>
              </div>
            </div>
            <Link className="button button--primary" to="/docs/INSTALLATION">
              Complete installation guide →
            </Link>
          </div>
        </section>

        <section className={styles.section}>
          <div className="container">
            <h2>Quick Example</h2>
            <pre className={styles.code}>
              <code>{`import { Printer, usePrintersDiscovery } from 'react-native-esc-pos-printer';

function App() {
  const { start, printers } = usePrintersDiscovery();

  const print = async () => {
    const printer = new Printer({ target: printers[0].target, deviceName: printers[0].deviceName });
    await printer.addQueueTask(async () => {
      await Printer.tryToConnectUntil(printer, (s) => s.online.statusCode === PrinterConstants.TRUE);
      await printer.addText('Hello, World!');
      await printer.addFeedLine();
      await printer.addCut();
      const result = await printer.sendData();
      await printer.disconnect();
      return result;
    });
  };

  return <Button title="Print" onPress={print} />;
}`}</code>
            </pre>
            <Link className="button button--secondary" to="/docs/printer">
              Full API reference →
            </Link>
          </div>
        </section>
      </main>
    </Layout>
  );
}
