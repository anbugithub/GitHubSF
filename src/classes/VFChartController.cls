public class VFChartController {

    public List<PieChartData> getChartData () {
        List<PieChartData> data = new List<PieChartData>();
        data.add(new PieChartData('RAM', 30));
        
        data.add(new PieChartData('Hard Disk', 15));
        data.add(new PieChartData('VGA Card', 10));
        data.add(new PieChartData('Mouse', 20));
        data.add(new PieChartData('USB Drive 16BG', 20));
        data.add(new PieChartData('USB Drive 32BG', 5));
        return data;
    }
    // Wrapper class
    public class PieChartData {
        public String name { get; set; }
        public Integer data { get; set; }
        
        public PieChartData(String name, Integer data) {
        this.name = name;
        this.data = data;
        }
    }
}