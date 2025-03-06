import java.util.Scanner;

public class TripCostCalculator {
    // Method to calculate trip cost
    public static double calculateTripCost(double kilometers, double fuelPrice, double fuelConsumptionPer100Km) {
        double fuelNeeded = (kilometers / 100) * fuelConsumptionPer100Km;
        return fuelNeeded * fuelPrice;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Ask user for the distance to travel
        System.out.print("Enter the number of kilometers to travel: ");
        double kilometers = scanner.nextDouble();

        // Ask user for the fuel price per liter
        System.out.print("Enter the fuel price per liter: ");
        double fuelPrice = scanner.nextDouble();

                // Ask user for the consumption rate
                System.out.print("Enter the comsumption rate: ");
                double fuelConsumptionPer100Km = scanner.nextDouble();

        // Calculate total cost of the trip
        double totalCost = calculateTripCost(kilometers, fuelPrice, fuelConsumptionPer100Km);

        // Display the total cost
        System.out.printf("The total cost of the trip is: %.2f euros\n", totalCost);

        scanner.close();
    }
}