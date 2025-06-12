using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TutorialPSOOP
{
    class CustomerTest
    {
        //Unit test for (x) property, null or empty
        //[TestMethod]
        public void FullNameTestValid()
        {
            //-- Arrange, set up for the test. create an instance of the class
            Customer customer = new Customer
            {
                FirstName = "Bilbo",
                LastName = "Baggins"
            };

            string expected = "Baggins, Bilbo";

            //-- Act, access the property or method we are testing
            string actual = customer.FullName;

            //-- Assert, determine if the test is as expected. Use .NET class
            Assert.AreEqual(expected, actual);
        }

        //[TestMethod]
        public void FullNameFirstNameEmpty()
        {
            //-- Arrange
            Customer customer = new Customer
            {
                LastName = "Baggins"
            };

            string expected = "Baggins";

            //-- Act
            string actual = customer.FullName;

            //-- Assert
            //Assert.AreEqual(expected, actual);
        }

        //[TestMethod]
        public void FullNameLastNameEmpty()
        {
            //-- Arrange
            Customer customer = new Customer
            {
                FirstName = "Bilbo"
            };

            string expected = "Bilbo";

            //-- Act
            string actual = customer.FullName;

            //-- Assert
            //Assert.AreEqual(expected, actual);
        }
        //[TestMethod]
        public void StaticTest()
        {
            //-- Arrange
            var c1 = new Customer();
            c1.FirstName = "Bilbo";
            Customer.InstanceCount += 1;

            var c2 = new Customer();
            c2.FirstName = "Frodo";
            Customer.InstanceCount += 1;

            var c3 = new Customer();
            c3.FirstName = "Rosie";
            Customer.InstanceCount += 1;

            //-- Act

            //-- Assert
            //Assert.AreEqual(3, Customer.InstanceCount);
        }

       // [TestMethod]
        public void ValidateValid()
        {
            //-- Arrange
            var customer = new Customer
            {
                LastName = "Baggins",
                EmailAddress = "fbaggins@hobbiton.me"
            };

            var expected = true;

            //-- Act
            var actual = customer.Validate();

            //-- Assert
            Assert.AreEqual(expected, actual);
        }
    }
}
