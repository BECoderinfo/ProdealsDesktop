import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageInvoice extends StatefulWidget {
  const ManageInvoice({super.key});

  @override
  State<ManageInvoice> createState() => _ManageInvoiceState();
}

class _ManageInvoiceState extends State<ManageInvoice> {
  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return Container(
      height: hit,
      width: wid,
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Invoice',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    FilledButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.green.darker),
                      ),
                      child: const Text(
                        '+ Create Invoice',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: wid / 5.1,
                      height: hit / 5.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Total Invoices'),
                              const Spacer(),
                              SizedBox(
                                height: wid / 28,
                                width: wid / 28,
                                child: SvgPicture.asset(
                                    'assets/images/svg/document_invoice.svg'),
                              ),
                            ],
                          ),
                          Text(
                            '198',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '+10% ',
                                  style: TextStyle(color: Colors.green),
                                ),
                                const TextSpan(text: 'From last Month'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: wid / 5.1,
                      height: hit / 5.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Total Clients'),
                              const Spacer(),
                              SizedBox(
                                height: wid / 28,
                                width: wid / 28,
                                child: SvgPicture.asset(
                                    'assets/images/svg/document_invoice.svg'),
                              ),
                            ],
                          ),
                          Text(
                            '105',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '+15% ',
                                  style: TextStyle(color: Colors.green),
                                ),
                                const TextSpan(text: 'From last Month'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: wid / 5.1,
                      height: hit / 5.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Outstanding'),
                              const Spacer(),
                              SizedBox(
                                  height: wid / 28,
                                  width: wid / 28,
                                  child: SvgPicture.asset(
                                      'assets/images/svg/money2.svg')),
                            ],
                          ),
                          Text(
                            '\$39,450.9',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '+9.5% ',
                                  style: TextStyle(color: Colors.green),
                                ),
                                const TextSpan(text: 'From last Month'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: wid / 5.1,
                      height: hit / 5.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Overdue'),
                              const Spacer(),
                              SizedBox(
                                height: wid / 28,
                                width: wid / 28,
                                child: SvgPicture.asset(
                                    'assets/images/svg/document_invoice.svg'),
                              ),
                            ],
                          ),
                          Text(
                            '\$3,450.9',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '+6.5% ',
                                  style: TextStyle(color: Colors.green),
                                ),
                                const TextSpan(text: 'From last Month'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                checked: false,
                                onChanged: (val) {},
                              ),
                              const Gap(4),
                              const Text('Invoice Id'),
                            ],
                          ),
                          const Text('Client Name'),
                          const Text('Date'),
                          const Text('Amount'),
                          const Text('Status'),
                          const Text('Action'),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                checked: false,
                                onChanged: (val) {},
                              ),
                              const Gap(4),
                              const Text('#INV66342'),
                            ],
                          ),
                          const Text('Gaurav Butani'),
                          const Text('12 feb 2024'),
                          const Text('\$6700.5'),
                          const Text('Rejected'),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(FluentIcons.red_eye),
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.blue),
                                ),
                              ),
                              const Gap(10),
                              IconButton(
                                icon: const Icon(FluentIcons.delete),
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                checked: false,
                                onChanged: (val) {},
                              ),
                              const Gap(4),
                              const Text('#INV66342'),
                            ],
                          ),
                          const Text('Gaurav Butani'),
                          const Text('12 feb 2024'),
                          const Text('\$6700.5'),
                          const Text('Rejected'),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(FluentIcons.red_eye),
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.blue),
                                ),
                              ),
                              const Gap(10),
                              IconButton(
                                icon: const Icon(FluentIcons.delete),
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PDF',
                      style: TextStyle(fontSize: 10),
                    ),
                    Gap(4),
                    Text('Report'),
                  ],
                ),
                const Gap(20),
                Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Download'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
