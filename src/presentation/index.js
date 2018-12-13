// Import React
import React from "react";

// Import Spectacle Core tags
import {
  BlockQuote,
  Cite,
  Deck,
  Heading,
  ListItem,
  List,
  Quote,
  Slide,
  Text,
  Image
} from "spectacle";

// Import theme
import createTheme from "spectacle/lib/themes/default";

// Require CSS
require("normalize.css");

const theme = createTheme(
  {
    primary: "#1C2022", //background color
    secondary: "#EB0A44", //main heading text
    tertiary: "white", //normal text
    quarternary: "white"
  },
  {
    primary: "Montserrat",
    secondary: "Helvetica"
  }
);

const SlideHeading = ({ text }) => {
  return (
    <Heading size={1} fit caps lineHeight={1} textColor="secondary">
      {text}
    </Heading>
  );
};

const SubHeading = ({ text, size }) => {
  return (
    <Text margin="10px 0 0" textColor="tertiary" size={size || 1} fit bold>
      {text}
    </Text>
  );
};

const ExtendedSlide = ({ children }) => {
  return <Slide>{children}</Slide>;
};

export default class Presentation extends React.Component {
  render() {
    return (
      <Deck
        transition={["slide"]}
        transitionDuration={500}
        theme={theme}
        progress="bar"
        bgColor="primary"
      >
        <ExtendedSlide>
          <SlideHeading text="YO total" />
          <SubHeading text="Building apps in the browser" />
        </ExtendedSlide>
        <ExtendedSlide>
          <SlideHeading text="So you want to be a rock superstar" />
          <SubHeading text="And live large" size={3} />
          <SubHeading
            text="A big house. Five cars, You're in charge"
            size={3}
          />
          <Image src="https://media.giphy.com/media/NnJib5EkPyym4/giphy.gif" />
        </ExtendedSlide>
        <ExtendedSlide>
          <SlideHeading text="1337 h4x0r developer" />
          <Image src="https://media.giphy.com/media/x43pXtJShv93a/giphy.gif" />
        </ExtendedSlide>
        <ExtendedSlide>
          <SlideHeading text="super powerful laptop" />
          <Image src="https://media.giphy.com/media/adhuPKADfzrDG/giphy.gif" />
        </ExtendedSlide>
        <ExtendedSlide>
          <Image src="https://media.giphy.com/media/3o6nUXbNjnNXrgqif6/giphy.gif" />
        </ExtendedSlide>
        <ExtendedSlide>
          <iframe
            title="demo"
            style={{
              width: "100%",
              height: "600px",
              border: "0",
              borderRadius: "4px",
              overflow: "hidden"
            }}
            src="https://codesandbox.io/embed/qx4knj9ox9"
            sandbox="allow-modals allow-forms allow-popups allow-scripts allow-same-origin"
          />
        </ExtendedSlide>
        <ExtendedSlide>
          <SlideHeading text="Really?" />
        </ExtendedSlide>
        <ExtendedSlide>
          <SlideHeading text="codesandbox" />
          <Image src="https://media.giphy.com/media/5yLgocAcF0DYJHZtQqs/giphy.gif" />
        </ExtendedSlide>
        <ExtendedSlide>
          <Heading size={6} textColor="secondary">
            <a href="https://znxo3po954.codesandbox.io/#/">YO TOTAL: Sandbox</a>
          </Heading>
        </ExtendedSlide>
        <ExtendedSlide>
          <Heading size={6} textColor="secondary">
            <a href="https://yo-total.netlify.com/">YO TOTAL: Netlify</a>
          </Heading>
        </ExtendedSlide>
        <ExtendedSlide>
          <Heading size={6} textColor="secondary">
            <a href="https://github.com/chrislaughlin/yo-total">
              YO TOTAL: Github
            </a>
          </Heading>
        </ExtendedSlide>
        <ExtendedSlide>
          <Heading size={6} textColor="secondary">
            Slides
          </Heading>
          <a href="https://znxo3po954.codesandbox.io/#/">
            https://znxo3po954.codesandbox.io/#/
          </a>
        </ExtendedSlide>
      </Deck>
    );
  }
}
